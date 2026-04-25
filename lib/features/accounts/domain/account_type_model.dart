import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_type_model.freezed.dart';

@freezed
class AccountType with _$AccountType {
  const factory AccountType({
    String? id,
    required String typeCode,
    required String typeLabel,
    required bool isSystem,
    required DateTime createdAt,
  }) = _AccountType;

  const AccountType._();

  factory AccountType.fromFirestore(DocumentSnapshot doc) {
    final m = doc.data() as Map<String, dynamic>;
    return AccountType(
      id: doc.id,
      typeCode: m['typeCode'] as String,
      typeLabel: m['typeLabel'] as String,
      isSystem: m['isSystem'] as bool? ?? false,
      createdAt: (m['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'typeCode': typeCode,
        'typeLabel': typeLabel,
        'isSystem': isSystem,
        'createdAt': id == null
            ? Timestamp.now()
            : Timestamp.fromDate(createdAt.toUtc()),
      };
}
