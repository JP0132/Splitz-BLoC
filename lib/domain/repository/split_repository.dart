import 'package:splitz_bloc/data/models/favourite_model.dart';
import 'package:splitz_bloc/data/models/split_model.dart';

abstract interface class SplitRepository {
  Future<void> createSplit(SplitModel split);
  Future<List<SplitModel>> getAllSplits();
  Future<SplitModel> getSplitById(String splitId);
  Future<bool> favouriteSplit(FavouriteModel favSplit);
  Future<bool> checkFavouriteStatus(String splitId, String userId);
  Future<SplitModel?> getFavourited();
  Future<void> editSplit(SplitModel split);
  Future<void> deleteSplit(String splitId);
}
