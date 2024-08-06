import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ExpenseRepositoryImpl({required this.firestore, required this.auth});

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final docRef = firestore.collection('expenses').doc();
    final newExpense = expense.copyWith(
      id: docRef.id,
    );

    await docRef.set(newExpense.toMap());
  }

  @override
  Future<List<ExpenseModel>> getExpenses(String splitId) async {
    final snapshot = await firestore
        .collection('expenses')
        .where('splitId', isEqualTo: splitId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ExpenseModel.fromMap(data);
    }).toList();
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    await firestore.collection('expenses').doc(expenseId).delete();
  }
}
