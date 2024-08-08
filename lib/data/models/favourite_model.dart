import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteModel {
  final String id;
  final String splitId;
  final String userId;

  FavouriteModel({
    required this.splitId,
    required this.id,
    required this.userId,
  });

  FavouriteModel copyWith({
    String? id,
    String? userId,
    String? splitId,
  }) {
    return FavouriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      splitId: userId ?? this.splitId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'splitId': splitId,
      'userId': userId,
    };
  }

  factory FavouriteModel.fromMap(Map<dynamic, dynamic> map) {
    return FavouriteModel(
      id: map['id'] as String,
      splitId: map['userId'] as String? ?? "",
      userId: map['userId'] as String? ?? "",
    );
  }
}
