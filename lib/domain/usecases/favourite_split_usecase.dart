import 'package:splitz_bloc/data/models/favourite_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class FavouriteSplitUsecase {
  final SplitRepository repository;

  FavouriteSplitUsecase(this.repository);

  Future<void> call(String userId, String splitId) {
    final favSplit = FavouriteModel(
      id: '',
      userId: userId,
      splitId: splitId,
    );
    return repository.favouriteSplit(favSplit);
  }
}
