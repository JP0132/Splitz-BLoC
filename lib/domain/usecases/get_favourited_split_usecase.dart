import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class GetFavouritedSplitUsecase {
  final SplitRepository repository;

  GetFavouritedSplitUsecase(this.repository);

  Future<SplitModel?> call() {
    return repository.getFavourited();
  }
}
