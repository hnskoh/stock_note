import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/firebase/firebase_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../domain/account_type_model.dart';

final accountTypeRepositoryProvider = Provider<AccountTypeRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final userId = ref.watch(authStateProvider).valueOrNull?.id ?? '';
  return AccountTypeRepository(firestore: firestore, userId: userId);
});

class AccountTypeRepository {
  AccountTypeRepository({required this.firestore, required this.userId});

  final FirebaseFirestore firestore;
  final String userId;

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('users').doc(userId).collection('account_types');

  static final _epoch = DateTime.utc(2024, 1, 1);

  static final _defaults = [
    AccountType(
      typeCode: 'Securities',
      typeLabel: '일반 증권',
      isSystem: true,
      createdAt: _epoch,
    ),
    AccountType(
      typeCode: 'DC',
      typeLabel: 'DC 퇴직연금',
      isSystem: true,
      createdAt: _epoch,
    ),
    AccountType(
      typeCode: 'IRP',
      typeLabel: 'IRP 퇴직연금',
      isSystem: true,
      createdAt: _epoch,
    ),
  ];

  Future<List<AccountType>> getAll() async {
    try {
      if (userId.isEmpty) return [];
      await _ensureDefaultTypes();
      final snapshot = await _col.get();
      return snapshot.docs.map(AccountType.fromFirestore).toList();
    } catch (e) {
      throw DatabaseException('계좌 유형 조회 실패: $e');
    }
  }

  Future<void> _ensureDefaultTypes() async {
    final snapshot = await _col.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;
    final batch = firestore.batch();
    for (final t in _defaults) {
      batch.set(_col.doc(), t.toFirestore());
    }
    await batch.commit();
  }

  Future<AccountType> insert(AccountType type) async {
    try {
      final doc = await _col.add(type.toFirestore());
      return type.copyWith(id: doc.id);
    } catch (e) {
      throw DatabaseException('계좌 유형 추가 실패: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      final doc = await _col.doc(id).get();
      if (!doc.exists) return;
      final isSystem = doc.data()?['isSystem'] as bool? ?? false;
      if (!isSystem) await _col.doc(id).delete();
    } catch (e) {
      throw DatabaseException('계좌 유형 삭제 실패: $e');
    }
  }
}
