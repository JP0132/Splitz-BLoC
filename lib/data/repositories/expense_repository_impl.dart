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

    final expenseRef = firestore.collection('expenses').doc();
    final splitRef = firestore.collection('splits').doc(expense.splitId);

    await firestore.runTransaction((transaction) async {
      final splitSnapshot = await transaction.get(splitRef);

      if (!splitSnapshot.exists) {
        throw Exception('Split does not exist!');
      }

      final newTotalAmount =
          (splitSnapshot.data()?['totalAmount'] ?? 0) + expense.paid;
      // transaction.set(expenseRef, expense.toMap());
      transaction.update(splitRef, {'totalAmount': newTotalAmount});
    });

    // final docRef = firestore.collection('expenses').doc();
    final newExpense = expense.copyWith(
      id: expenseRef.id,
      userId: user.uid,
    );

    await expenseRef.set(newExpense.toMap());
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
  Future<void> deleteExpense(ExpenseModel expense) async {
    final expenseRef = firestore.collection('expenses').doc(expense.id);
    final splitRef = firestore.collection('splits').doc(expense.splitId);

    await firestore.runTransaction((transaction) async {
      final splitSnapshot = await transaction.get(splitRef);

      if (!splitSnapshot.exists) {
        throw Exception('Split does not exist!');
      }

      final newTotalAmount =
          (splitSnapshot.data()?['totalAmount'] ?? 0) - expense.paid;
      //transaction.delete(expenseRef, expense.id)
      transaction.update(splitRef, {'totalAmount': newTotalAmount});
    });

    await expenseRef.delete();
    //await firestore.collection('expenses').doc(expense.id).delete();
  }

  @override
  Future<void> editExpense(ExpenseModel expense) async {
    // Retrieve the document reference for the expense and split

    try {
      final expenseRef = firestore.collection('expenses').doc(expense.id);
      final expenseSnapshot = await expenseRef.get();

      if (!expenseSnapshot.exists) {
        throw Exception("Expense does not exist!");
      }

      double difference;

      if (expense.paid != expenseSnapshot.get("paid")) {
        final oldPaid = expenseSnapshot.get("paid");
        difference = expense.paid - oldPaid;
        final splitRef = firestore.collection("splits").doc(expense.splitId);

        await firestore.runTransaction((transaction) async {
          final splitSnapshot = await transaction.get(splitRef);

          if (!splitSnapshot.exists) {
            throw Exception('Split does not exist!');
          }
          final newTotalAmount =
              (splitSnapshot.data()?['totalAmount'] ?? 0) + difference;
          transaction.update(splitRef, {'totalAmount': newTotalAmount});
        });
      }

      await expenseRef.update(expense.toMap());
    } catch (e) {
      // Handle any errors that might occur
      throw Exception('Failed to update expense: $e');
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final expenseRef = await firestore
        .collection('expenses')
        .where('userId', isEqualTo: user.uid)
        .get();

    return expenseRef.docs.map((doc) {
      final data = doc.data();
      return ExpenseModel.fromMap(data);
    }).toList();
  }
}
