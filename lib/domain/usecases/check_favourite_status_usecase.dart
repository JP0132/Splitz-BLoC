import 'package:splitz_bloc/domain/repository/split_repository.dart';

class CheckFavouriteStatusUsecase {
  final SplitRepository repository;

  CheckFavouriteStatusUsecase(this.repository);

  Future<bool> call(String splitId, String userId) {
    return repository.checkFavouriteStatus(splitId, userId);
  }
}
