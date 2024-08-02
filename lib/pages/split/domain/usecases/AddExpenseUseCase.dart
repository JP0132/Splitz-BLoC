import 'package:splitz_bloc/pages/split/data/models/expense_model.dart';
import 'package:splitz_bloc/pages/split/domain/repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  @override
  Future<void> call(ExpenseModel expense) async {
    await repository.addExpense(expense);
  }
}
