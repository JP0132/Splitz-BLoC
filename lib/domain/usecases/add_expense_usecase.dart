import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  @override
  Future<void> call(ExpenseModel expense) async {
    await repository.addExpense(expense);
  }
}
