import 'package:splitz_bloc/pages/split/data/models/expense_model.dart';
import 'package:splitz_bloc/pages/split/domain/repositories/expense_repository.dart';

class GetExpensesforSplitUseCase {
  final ExpenseRepository repository;

  GetExpensesforSplitUseCase(this.repository);

  Future<List<ExpenseModel>> call(String splitId) {
    return repository.getExpenses(splitId);
  }
}
