import 'package:splitz_bloc/data/models/expense_model.dart';

abstract interface class ExpenseRepository {
  Future<void> addExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getExpenses(String splitId);
  Future<void> deleteExpense(String expenseId);
  Future<void> editExpense(ExpenseModel expense);
}
