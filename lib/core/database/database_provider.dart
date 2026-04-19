import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database_helper.dart';

export 'database_helper.dart' show Database;

final databaseProvider = FutureProvider<Database>((ref) async {
  final db = await openAppDatabase();
  ref.onDispose(db.close);
  return db;
});
