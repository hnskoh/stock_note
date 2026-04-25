import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/firebase/firebase_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../domain/account_model.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final userId = ref.watch(authStateProvider).valueOrNull?.id ?? '';
  return AccountRepository(firestore: firestore, userId: userId);
});

class AccountRepository {
  AccountRepository({required this.firestore, required this.userId});

  final FirebaseFirestore firestore;
  final String userId;

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('users').doc(userId).collection('accounts');

  CollectionReference<Map<String, dynamic>> get _tradesCol =>
      firestore.collection('users').doc(userId).collection('trades');

  Future<List<Account>> getAll({bool activeOnly = true}) async {
    try {
      final snapshot = await _col.get();
      var accounts = snapshot.docs.map(Account.fromFirestore).toList();
      if (activeOnly) {
        accounts = accounts.where((a) => a.isActive).toList();
      }
      accounts.sort((a, b) {
        final order = a.sortOrder.compareTo(b.sortOrder);
        if (order != 0) return order;
        return b.createdAt.compareTo(a.createdAt);
      });
      return accounts;
    } catch (e) {
      throw DatabaseException('계좌 조회 실패: $e');
    }
  }

  Future<Account?> getById(String id) async {
    try {
      final doc = await _col.doc(id).get();
      if (!doc.exists) return null;
      return Account.fromFirestore(doc);
    } catch (e) {
      throw DatabaseException('계좌 조회 실패: $e');
    }
  }

  Future<Account> insert(Account account) async {
    try {
      final doc = await _col.add(account.toFirestore());
      return account.copyWith(id: doc.id);
    } catch (e) {
      throw DatabaseException('계좌 추가 실패: $e');
    }
  }

  Future<void> update(Account account) async {
    try {
      await _col.doc(account.id).update(account.toFirestore());
    } catch (e) {
      throw DatabaseException('계좌 수정 실패: $e');
    }
  }

  Future<void> deleteOrDeactivate(String id) async {
    try {
      final tradesSnap = await _tradesCol
          .where('accountId', isEqualTo: id)
          .limit(1)
          .get();
      if (tradesSnap.docs.isNotEmpty) {
        await _col.doc(id).update({
          'isActive': false,
          'updatedAt': Timestamp.now(),
        });
      } else {
        await _col.doc(id).delete();
      }
    } catch (e) {
      throw DatabaseException('계좌 삭제 실패: $e');
    }
  }

  Future<int> getTradeCount(String accountId) async {
    final snap =
        await _tradesCol.where('accountId', isEqualTo: accountId).count().get();
    return snap.count ?? 0;
  }
}
