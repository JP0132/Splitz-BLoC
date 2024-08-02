import 'package:splitz_bloc/pages/split/domain/repositories/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<void> call(String expenseId) async {
    await repository.deleteExpense(expenseId);
  }
}
