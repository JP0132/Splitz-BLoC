import 'package:splitz_bloc/pages/split/data/models/split_model.dart';
import 'package:splitz_bloc/pages/split/domain/repositories/split_repository.dart';

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
