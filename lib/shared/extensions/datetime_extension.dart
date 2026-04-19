import 'package:intl/intl.dart';

final _displayFmt = DateFormat('yyyy.MM.dd', 'ko_KR');
final _dbFmt = DateFormat('yyyy-MM-dd');

extension DateTimeExtension on DateTime {
  String toDbDateStr() => _dbFmt.format(this);
  String toDisplayDateStr() => _displayFmt.format(this);
  String toIso8601Utc() => toUtc().toIso8601String();

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
