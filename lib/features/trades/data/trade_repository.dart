import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/firebase/firebase_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../domain/trade_filter.dart';
import '../domain/trade_model.dart';

final tradeRepositoryProvider = Provider<TradeRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final userId = ref.watch(authStateProvider).valueOrNull?.id ?? '';
  return TradeRepository(firestore: firestore, userId: userId);
});

class TradeRepository {
  TradeRepository({required this.firestore, required this.userId});

  final FirebaseFirestore firestore;
  final String userId;

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('users').doc(userId).collection('trades');

  Future<List<TradeModel>> getFilteredTrades(TradeFilter filter) async {
    try {
      Query<Map<String, dynamic>> query =
          _col.orderBy('tradeDate', descending: true);

      if (filter.startDate != null) {
        query = query.where('tradeDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.utc(
              filter.startDate!.year,
              filter.startDate!.month,
              filter.startDate!.day,
            )));
      }
      if (filter.endDate != null) {
        query = query.where('tradeDate',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime.utc(
              filter.endDate!.year,
              filter.endDate!.month,
              filter.endDate!.day,
              23,
              59,
              59,
            )));
      }
      if (filter.accountId != null) {
        query = query.where('accountId', isEqualTo: filter.accountId);
      }

      final snapshot = await query.get();
      var trades = snapshot.docs.map(TradeModel.fromFirestore).toList();

      if (filter.tickerQuery?.isNotEmpty == true) {
        final q = filter.tickerQuery!.toLowerCase();
        trades =
            trades.where((t) => t.tickerName.toLowerCase().contains(q)).toList();
      }

      return trades;
    } catch (e) {
      throw DatabaseException('매매 기록 조회 실패: $e');
    }
  }

  Future<TradeModel?> getById(String id) async {
    try {
      final doc = await _col.doc(id).get();
      if (!doc.exists) return null;
      return TradeModel.fromFirestore(doc);
    } catch (e) {
      throw DatabaseException('매매 기록 조회 실패: $e');
    }
  }

  Future<TradeModel> insert(TradeModel trade) async {
    try {
      final doc = await _col.add(trade.toFirestore());
      return trade.copyWith(id: doc.id);
    } catch (e) {
      throw DatabaseException('매매 기록 추가 실패: $e');
    }
  }

  Future<void> update(TradeModel trade) async {
    try {
      await _col.doc(trade.id).update(trade.toFirestore());
    } catch (e) {
      throw DatabaseException('매매 기록 수정 실패: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _col.doc(id).delete();
    } catch (e) {
      throw DatabaseException('매매 기록 삭제 실패: $e');
    }
  }

  Future<List<String>> getDistinctTickers() async {
    try {
      final snapshot = await _col.get();
      final tickers = snapshot.docs
          .map((d) => d.data()['tickerName'] as String)
          .toSet()
          .toList()
        ..sort();
      return tickers;
    } catch (e) {
      throw DatabaseException('종목 목록 조회 실패: $e');
    }
  }

  Future<Map<String, double>> getSummary(
      DateTime startDate, DateTime endDate) async {
    try {
      final trades = await getFilteredTrades(
        TradeFilter(startDate: startDate, endDate: endDate),
      );
      double buy = 0, sell = 0;
      for (final t in trades) {
        if (t.action.code == 'BUY') {
          buy += t.totalAmount;
        } else {
          sell += t.totalAmount;
        }
      }
      return {'buy': buy, 'sell': sell};
    } catch (e) {
      throw DatabaseException('매매 요약 조회 실패: $e');
    }
  }
}
