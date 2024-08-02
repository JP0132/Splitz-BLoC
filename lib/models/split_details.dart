import 'package:intl/intl.dart';

class SplitDetails {
  final double totalAmount;
  final DateTime createdAt;
  final String name;
  final String colour;
  String category;

  SplitDetails({
    required this.totalAmount,
    required this.createdAt,
    required this.name,
    required this.colour,
    required this.category,
  });
}
