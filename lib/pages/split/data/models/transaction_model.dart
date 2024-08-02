class TransactionModel {
  final String id;
  final String splitId;
  final String name;
  final String type;
  final double paid;
  final double cost;
  final List<String> tags;
  final String notes;
  final DateTime dateTime;
  final String currency;

  TransactionModel({
    required this.name,
    required this.paid,
    required this.cost,
    required this.dateTime,
    required this.currency,
    required this.tags,
    required this.notes,
    required this.type,
    required this.id,
    required this.splitId,
  });

  // factory TransactionModel.fromMap(Map<dynamic, dynamic> map) {
  //   return TransactionModel(
  //     id: map['id'],
  //     name: '',
  //     totalAmount: map['totalAmount'],
  //     dateTime: map['dateTime'],
  //     currency: map['currency'],
  //     colour: map['colour'],
  //     logo: map['logo'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'totalAmount': totalAmount,
  //     'dateTime': dateTime,
  //     'currency': currency,
  //     'colour': colour,
  //     'logo': logo,
  //   };
  // }
}
