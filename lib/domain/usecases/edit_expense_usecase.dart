import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class EditExpenseUsecase {
  final ExpenseRepository repository;

  EditExpenseUsecase(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.editExpense(expense);
  }
}
