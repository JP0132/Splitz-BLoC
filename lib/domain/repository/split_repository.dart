import 'package:splitz_bloc/data/models/split_model.dart';

abstract interface class SplitRepository {
  Future<void> createSplit(SplitModel split);
  Future<List<SplitModel>> getAllSplits();
  Future<SplitModel> getSplitById(String splitId);
  Future<void> favouriteSplit(String splitId, String userId);
}
