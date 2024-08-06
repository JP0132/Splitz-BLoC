import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class CreateSplitUseCase {
  final SplitRepository repository;

  CreateSplitUseCase(this.repository);

  Future<void> call(
      String name, String category, String colour, String currency) {
    final split = SplitModel(
      id: '',
      name: name,
      category: category,
      colour: colour,
      currency: currency,
      userId: '',
      totalAmount: 0,
      dateTime: DateTime.now(),
    );
    return repository.createSplit(split);
  }
}
