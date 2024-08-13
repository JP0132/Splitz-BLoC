import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class EditSplitUsecase {
  final SplitRepository repository;

  EditSplitUsecase(this.repository);

  Future<void> call(SplitModel split) async {
    await repository.editSplit(split);
  }
}
