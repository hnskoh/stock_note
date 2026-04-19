import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    int? id,
    required String name,
    required String type,
    required bool isActive,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    // 조인용 (query에서 채워짐)
    String? typeLabel,
  }) = _Account;

  const Account._();

  factory Account.fromMap(Map<String, dynamic> m) => Account(
        id: m['id'] as int?,
        name: m['name'] as String,
        type: m['type'] as String,
        isActive: (m['is_active'] as int) == 1,
        sortOrder: m['sort_order'] as int,
        createdAt: DateTime.parse(m['created_at'] as String),
        updatedAt: DateTime.parse(m['updated_at'] as String),
        typeLabel: m['type_label'] as String?,
      );

  Map<String, dynamic> toMap() {
    final now = DateTime.now().toUtc().toIso8601String();
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'is_active': isActive ? 1 : 0,
      'sort_order': sortOrder,
      'created_at': id == null ? now : createdAt.toUtc().toIso8601String(),
      'updated_at': now,
    };
  }
}
