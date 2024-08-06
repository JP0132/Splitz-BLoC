import 'package:cloud_firestore/cloud_firestore.dart';

class SplitModel {
  final String id;
  final String name;
  final String category;
  final double totalAmount;
  final DateTime dateTime;
  final String currency;
  final String colour;
  final String userId;

  SplitModel(
      {required this.name,
      required this.category,
      required this.totalAmount,
      required this.dateTime,
      required this.currency,
      required this.colour,
      required this.id,
      required this.userId});

  SplitModel copyWith({
    String? id,
    String? name,
    String? category,
    double? totalAmount,
    DateTime? dateTime,
    String? currency,
    String? colour,
    String? userId,
  }) {
    return SplitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      colour: colour ?? this.colour,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      dateTime: dateTime ?? this.dateTime,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'totalAmount': totalAmount,
      'dateTime': dateTime,
      'currency': currency,
      'colour': colour,
      'userId': userId,
    };
  }

  factory SplitModel.fromMap(Map<dynamic, dynamic> map) {
    return SplitModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? "",
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] as String? ?? "",
      dateTime: (map['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currency: map['currency'] as String? ?? "",
      colour: map['colour'] as String? ?? "",
      userId: map['userId'] as String? ?? "",
    );
  }
}
