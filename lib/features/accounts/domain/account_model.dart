import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    String? id,
    required String name,
    required String type,
    required bool isActive,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? typeLabel,
  }) = _Account;

  const Account._();

  factory Account.fromFirestore(DocumentSnapshot doc) {
    final m = doc.data() as Map<String, dynamic>;
    return Account(
      id: doc.id,
      name: m['name'] as String,
      type: m['type'] as String,
      isActive: m['isActive'] as bool? ?? true,
      sortOrder: m['sortOrder'] as int? ?? 0,
      createdAt: (m['createdAt'] as Timestamp).toDate(),
      updatedAt: (m['updatedAt'] as Timestamp).toDate(),
      typeLabel: m['typeLabel'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    final now = Timestamp.now();
    return {
      'name': name,
      'type': type,
      'typeLabel': typeLabel,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': id == null ? now : Timestamp.fromDate(createdAt.toUtc()),
      'updatedAt': now,
    };
  }
}
