import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:stock_note/core/database/database_helper.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('스키마 생성: 4개 테이블 확인', () async {
    final db = await openAppDatabase();
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name",
    );
    final names = tables.map((r) => r['name'] as String).toSet();
    expect(
      names,
      containsAll(['accounts', 'account_types', 'db_metadata', 'trade_logs']),
    );
    await db.close();
  });

  test('시드 데이터: account_types 3개 확인', () async {
    final db = await openAppDatabase();
    final rows = await db.query('account_types');
    expect(rows.length, greaterThanOrEqualTo(3));
    final codes =
        rows.map((r) => r['type_code'] as String).toSet();
    expect(codes, containsAll(['Securities', 'DC', 'IRP']));
    await db.close();
  });

  test('시드 데이터: db_metadata 키 확인', () async {
    final db = await openAppDatabase();
    final rows = await db.query('db_metadata');
    final keys =
        rows.map((r) => r['key'] as String).toSet();
    expect(keys, containsAll(['db_version', 'last_synced_at', 'created_at']));
    await db.close();
  });
}
