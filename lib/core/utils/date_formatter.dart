import 'package:intl/intl.dart';

final _displayFormat = DateFormat('yyyy.MM.dd', 'ko_KR');
final _dbFormat = DateFormat('yyyy-MM-dd');

String toDisplayDate(DateTime dt) => _displayFormat.format(dt);

String toDbDate(DateTime dt) => _dbFormat.format(dt);

DateTime fromDbDate(String s) => _dbFormat.parse(s);

String toIso8601(DateTime dt) => dt.toUtc().toIso8601String();

DateTime fromIso8601(String s) => DateTime.parse(s).toLocal();
