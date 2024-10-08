import 'package:splitz_bloc/data/models/expense_model.dart';

abstract interface class ExpenseRepository {
  Future<void> addExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getExpenses(String splitId);
  Future<List<ExpenseModel>> getAllExpenses();
  Future<void> deleteExpense(ExpenseModel expense);
  Future<void> editExpense(ExpenseModel expense);
}
