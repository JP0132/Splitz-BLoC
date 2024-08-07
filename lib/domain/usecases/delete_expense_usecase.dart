import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.deleteExpense(expense);
  }
}
