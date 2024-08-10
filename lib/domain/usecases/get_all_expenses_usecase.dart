import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class GetAllExpensesUsecase {
  final ExpenseRepository repository;

  GetAllExpensesUsecase(this.repository);

  Future<List<ExpenseModel>> call() {
    return repository.getAllExpenses();
  }
}
