import 'package:splitz_bloc/pages/split/data/models/split_model.dart';

abstract interface class SplitRepository {
  Future<void> createSplit(SplitModel split);
  Future<List<SplitModel>> getAllSplits();
}
