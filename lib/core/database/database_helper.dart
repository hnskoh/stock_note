import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../constants/app_constants.dart';

export 'package:sqflite_common_ffi/sqflite_ffi.dart' show Database;

Future<Database> openAppDatabase() async {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWebBasicWebWorker;
    return openDatabase(
      AppConstants.dbFileName,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  } else {
    final dbPath = await sqflite.getDatabasesPath();
    final path = join(dbPath, AppConstants.dbFileName);
    return openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }
}

Future<void> _onOpen(Database db) async {
  if (kIsWeb) return;
  await db.execute('PRAGMA foreign_keys = ON');
  await db.execute('PRAGMA journal_mode = WAL');
}

Future<void> _onCreate(Database db, int version) async {
  await db.execute(_schemaSql);
  await _insertSeedData(db);
}

Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  for (int v = oldVersion + 1; v <= newVersion; v++) {
    switch (v) {
      // Future migrations go here:
      // case 2: await db.execute('ALTER TABLE ...');
      default:
        break;
    }
  }
}

Future<void> _insertSeedData(Database db) async {
  final now = DateTime.now().toUtc().toIso8601String();

  // db_metadata
  await db.insert('db_metadata', {'key': 'db_version', 'value': '1'});
  await db.insert('db_metadata', {'key': 'last_synced_at', 'value': ''});
  await db.insert('db_metadata', {'key': 'created_at', 'value': now});

  // account_types (시스템 기본값)
  for (final type in [
    {'type_code': 'Securities', 'type_label': '일반 증권', 'is_system': 1},
    {'type_code': 'DC', 'type_label': 'DC 퇴직연금', 'is_system': 1},
    {'type_code': 'IRP', 'type_label': 'IRP 퇴직연금', 'is_system': 1},
  ]) {
    await db.insert('account_types', {...type, 'created_at': now});
  }
}

const String _schemaSql = '''
CREATE TABLE IF NOT EXISTS db_metadata (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS account_types (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  type_code  TEXT    NOT NULL UNIQUE,
  type_label TEXT    NOT NULL,
  is_system  INTEGER NOT NULL DEFAULT 0,
  created_at TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  name       TEXT    NOT NULL,
  type       TEXT    NOT NULL,
  is_active  INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT    NOT NULL,
  updated_at TEXT    NOT NULL,
  FOREIGN KEY (type) REFERENCES account_types(type_code)
);

CREATE TABLE IF NOT EXISTS trade_logs (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  account_id   INTEGER NOT NULL,
  trade_date   TEXT    NOT NULL,
  ticker_name  TEXT    NOT NULL,
  action       TEXT    NOT NULL CHECK(action IN ('BUY', 'SELL')),
  quantity     REAL    NOT NULL CHECK(quantity > 0),
  price        REAL    NOT NULL CHECK(price >= 0),
  fee          REAL    NOT NULL DEFAULT 0 CHECK(fee >= 0),
  total_amount REAL    NOT NULL,
  note         TEXT,
  created_at   TEXT    NOT NULL,
  updated_at   TEXT    NOT NULL,
  FOREIGN KEY (account_id) REFERENCES accounts(id)
);

CREATE INDEX IF NOT EXISTS idx_trade_logs_date    ON trade_logs(trade_date DESC);
CREATE INDEX IF NOT EXISTS idx_trade_logs_account ON trade_logs(account_id);
CREATE INDEX IF NOT EXISTS idx_trade_logs_ticker  ON trade_logs(ticker_name);
''';
