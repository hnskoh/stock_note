import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/error/app_exception.dart';
import '../domain/trade_filter.dart';
import '../domain/trade_model.dart';

final tradeRepositoryProvider = Provider<TradeRepository>(
  (ref) => TradeRepository(ref),
);

class TradeRepository {
  TradeRepository(this._ref);
  final Ref _ref;

  static final _dbFmt = DateFormat('yyyy-MM-dd');

  Future<List<TradeModel>> getFilteredTrades(TradeFilter filter) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final whereClauses = <String>[];
      final args = <dynamic>[];

      if (filter.startDate != null) {
        whereClauses.add('t.trade_date >= ?');
        args.add(_dbFmt.format(filter.startDate!));
      }
      if (filter.endDate != null) {
        whereClauses.add('t.trade_date <= ?');
        args.add(_dbFmt.format(filter.endDate!));
      }
      if (filter.accountId != null) {
        whereClauses.add('t.account_id = ?');
        args.add(filter.accountId!);
      }
      if (filter.tickerQuery?.isNotEmpty == true) {
        whereClauses.add('t.ticker_name LIKE ?');
        args.add('%${filter.tickerQuery}%');
      }

      final where = whereClauses.isEmpty
          ? ''
          : 'WHERE ${whereClauses.join(' AND ')}';

      final rows = await db.rawQuery('''
        SELECT t.*, a.name AS account_name
        FROM trade_logs t
        LEFT JOIN accounts a ON t.account_id = a.id
        $where
        ORDER BY t.trade_date DESC, t.created_at DESC
      ''', args.isEmpty ? null : args);

      return rows.map(TradeModel.fromMap).toList();
    } catch (e) {
      throw DatabaseException('매매 기록 조회 실패: $e');
    }
  }

  Future<TradeModel?> getById(int id) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.rawQuery('''
        SELECT t.*, a.name AS account_name
        FROM trade_logs t
        LEFT JOIN accounts a ON t.account_id = a.id
        WHERE t.id = ?
      ''', [id]);
      if (rows.isEmpty) return null;
      return TradeModel.fromMap(rows.first);
    } catch (e) {
      throw DatabaseException('매매 기록 조회 실패: $e');
    }
  }

  Future<TradeModel> insert(TradeModel trade) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final id = await db.insert('trade_logs', trade.toMap());
      return trade.copyWith(id: id);
    } catch (e) {
      throw DatabaseException('매매 기록 추가 실패: $e');
    }
  }

  Future<void> update(TradeModel trade) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      await db.update('trade_logs', trade.toMap(),
          where: 'id = ?', whereArgs: [trade.id]);
    } catch (e) {
      throw DatabaseException('매매 기록 수정 실패: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      await db.delete('trade_logs', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw DatabaseException('매매 기록 삭제 실패: $e');
    }
  }

  Future<List<String>> getDistinctTickers() async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.rawQuery(
        'SELECT DISTINCT ticker_name FROM trade_logs ORDER BY ticker_name ASC',
      );
      return rows.map((r) => r['ticker_name'] as String).toList();
    } catch (e) {
      throw DatabaseException('종목 목록 조회 실패: $e');
    }
  }

  Future<Map<String, double>> getSummary(
      DateTime startDate, DateTime endDate) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.rawQuery('''
        SELECT action, SUM(total_amount) as total
        FROM trade_logs
        WHERE trade_date >= ? AND trade_date <= ?
        GROUP BY action
      ''', [_dbFmt.format(startDate), _dbFmt.format(endDate)]);

      double buy = 0, sell = 0;
      for (final row in rows) {
        if (row['action'] == 'BUY') {
          buy = (row['total'] as num).toDouble();
        } else {
          sell = (row['total'] as num).toDouble();
        }
      }
      return {'buy': buy, 'sell': sell};
    } catch (e) {
      throw DatabaseException('매매 요약 조회 실패: $e');
    }
  }
}
