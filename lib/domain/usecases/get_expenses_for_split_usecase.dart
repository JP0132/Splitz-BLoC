import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/domain/repository/expense_repository.dart';

class GetExpensesforSplitUseCase {
  final ExpenseRepository repository;

  GetExpensesforSplitUseCase(this.repository);

  Future<List<ExpenseModel>> call(String splitId) {
    return repository.getExpenses(splitId);
  }
}
