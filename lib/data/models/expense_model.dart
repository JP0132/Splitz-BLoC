import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final String id;
  final String splitId;
  final String name;
  final String type;
  final double paid;
  final double cost;
  final List<String> tags;
  final String notes;
  final DateTime dateTimeAdded;
  final DateTime datePaid;
  final String currency;
  final String userId;

  ExpenseModel(
      {required this.name,
      required this.paid,
      required this.cost,
      required this.dateTimeAdded,
      required this.datePaid,
      required this.currency,
      required this.tags,
      required this.notes,
      required this.type,
      required this.id,
      required this.splitId,
      required this.userId});

  ExpenseModel copyWith({
    String? id,
    String? name,
    String? type,
    double? paid,
    double? cost,
    DateTime? dateTime,
    String? currency,
    List<String>? tags,
    String? notes,
    String? splitId,
    String? userId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      splitId: splitId ?? this.splitId,
      name: name ?? this.name,
      type: type ?? this.type,
      cost: cost ?? this.cost,
      paid: paid ?? this.paid,
      dateTimeAdded: dateTime ?? this.dateTimeAdded,
      datePaid: dateTime ?? this.datePaid,
      currency: currency ?? this.currency,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'cost': cost,
      'paid': paid,
      'dateTimeAdded': dateTimeAdded,
      'currency': currency,
      'tags': tags,
      'notes': notes,
      'splitId': splitId,
      'userId': userId,
      'datePaid': datePaid,
    };
  }

  factory ExpenseModel.fromMap(Map<dynamic, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? "",
      cost: (map['cost'] as num?)?.toDouble() ?? 0.0,
      paid: (map['paid'] as num?)?.toDouble() ?? 0.0,
      type: map['type'] as String? ?? '',
      tags: (map['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          [],
      dateTimeAdded:
          (map['dateTimeAdded'] as Timestamp?)?.toDate() ?? DateTime.now(),
      datePaid: (map['datePaid'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currency: map['currency'] as String? ?? "",
      notes: map['notes'] as String? ?? "",
      splitId: map['splitId'] as String? ?? "",
      userId: map['userId'] as String? ?? "",
    );
  }
}
