import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/error/app_exception.dart';
import '../domain/account_type_model.dart';

final accountTypeRepositoryProvider = Provider<AccountTypeRepository>(
  (ref) => AccountTypeRepository(ref),
);

class AccountTypeRepository {
  AccountTypeRepository(this._ref);
  final Ref _ref;

  Future<List<AccountType>> getAll() async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.query('account_types', orderBy: 'id ASC');
      return rows.map(AccountType.fromMap).toList();
    } catch (e) {
      throw DatabaseException('계좌 유형 조회 실패: $e');
    }
  }

  Future<AccountType> insert(AccountType type) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final id = await db.insert('account_types', type.toMap());
      return type.copyWith(id: id);
    } catch (e) {
      throw DatabaseException('계좌 유형 추가 실패: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      await db.delete('account_types',
          where: 'id = ? AND is_system = 0', whereArgs: [id]);
    } catch (e) {
      throw DatabaseException('계좌 유형 삭제 실패: $e');
    }
  }
}
