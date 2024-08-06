import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class GetAllSplitsUseCase {
  final SplitRepository repository;

  GetAllSplitsUseCase(this.repository);

  Future<List<SplitModel>> call() {
    return repository.getAllSplits();
  }
}
