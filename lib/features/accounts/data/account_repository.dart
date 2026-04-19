import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/error/app_exception.dart';
import '../domain/account_model.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(ref),
);

class AccountRepository {
  AccountRepository(this._ref);
  final Ref _ref;

  Future<List<Account>> getAll({bool activeOnly = true}) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.rawQuery('''
        SELECT a.*, at.type_label
        FROM accounts a
        LEFT JOIN account_types at ON a.type = at.type_code
        ${activeOnly ? 'WHERE a.is_active = 1' : ''}
        ORDER BY a.sort_order ASC, a.created_at DESC
      ''');
      return rows.map(Account.fromMap).toList();
    } catch (e) {
      throw DatabaseException('계좌 조회 실패: $e');
    }
  }

  Future<Account?> getById(int id) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final rows = await db.rawQuery('''
        SELECT a.*, at.type_label
        FROM accounts a
        LEFT JOIN account_types at ON a.type = at.type_code
        WHERE a.id = ?
      ''', [id]);
      if (rows.isEmpty) return null;
      return Account.fromMap(rows.first);
    } catch (e) {
      throw DatabaseException('계좌 조회 실패: $e');
    }
  }

  Future<Account> insert(Account account) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final id = await db.insert('accounts', account.toMap());
      return account.copyWith(id: id);
    } catch (e) {
      throw DatabaseException('계좌 추가 실패: $e');
    }
  }

  Future<void> update(Account account) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      await db.update('accounts', account.toMap(),
          where: 'id = ?', whereArgs: [account.id]);
    } catch (e) {
      throw DatabaseException('계좌 수정 실패: $e');
    }
  }

  Future<void> deleteOrDeactivate(int id) async {
    try {
      final db = await _ref.read(databaseProvider.future);
      final trades = await db.query(
        'trade_logs',
        where: 'account_id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (trades.isNotEmpty) {
        await db.update(
          'accounts',
          {
            'is_active': 0,
            'updated_at': DateTime.now().toUtc().toIso8601String()
          },
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
      }
    } catch (e) {
      throw DatabaseException('계좌 삭제 실패: $e');
    }
  }

  Future<int> getTradeCount(int accountId) async {
    final db = await _ref.read(databaseProvider.future);
    final result = await db.rawQuery(
      'SELECT COUNT(*) as cnt FROM trade_logs WHERE account_id = ?',
      [accountId],
    );
    return result.first['cnt'] as int;
  }
}
