import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class GetSplitByIdUsecase {
  final SplitRepository repository;

  GetSplitByIdUsecase(this.repository);

  Future<SplitModel> call(String splitId) {
    return repository.getSplitById(splitId);
  }
}
