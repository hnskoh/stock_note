import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_type_model.freezed.dart';

@freezed
class AccountType with _$AccountType {
  const factory AccountType({
    int? id,
    required String typeCode,
    required String typeLabel,
    required bool isSystem,
    required DateTime createdAt,
  }) = _AccountType;

  const AccountType._();

  factory AccountType.fromMap(Map<String, dynamic> m) => AccountType(
        id: m['id'] as int?,
        typeCode: m['type_code'] as String,
        typeLabel: m['type_label'] as String,
        isSystem: (m['is_system'] as int) == 1,
        createdAt: DateTime.parse(m['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'type_code': typeCode,
        'type_label': typeLabel,
        'is_system': isSystem ? 1 : 0,
        'created_at': createdAt.toUtc().toIso8601String(),
      };
}
