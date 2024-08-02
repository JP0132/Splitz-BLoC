import 'package:splitz_bloc/pages/split/data/models/split_model.dart';
import 'package:splitz_bloc/pages/split/domain/repositories/split_repository.dart';

class GetAllSplitsUseCase {
  final SplitRepository repository;

  GetAllSplitsUseCase(this.repository);

  Future<List<SplitModel>> call() {
    return repository.getAllSplits();
  }
}
