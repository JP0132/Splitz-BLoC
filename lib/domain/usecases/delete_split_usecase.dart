import 'package:splitz_bloc/domain/repository/split_repository.dart';

class DeleteSplitUsecase {
  final SplitRepository repository;

  DeleteSplitUsecase(this.repository);

  Future<void> call(String splitId) async {
    await repository.deleteSplit(splitId);
  }
}
