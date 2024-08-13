import 'package:equatable/equatable.dart';
import 'package:splitz_bloc/domain/entities/user.dart';
import 'package:splitz_bloc/data/models/split_model.dart';

abstract class SplitState extends Equatable {
  const SplitState();

  @override
  List<Object?> get props => [];
}

class SplitInitial extends SplitState {}

class SplitLoading extends SplitState {}

class SplitFailure extends SplitState {
  final String message;

  const SplitFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class SplitSuccess extends SplitState {}

class SplitsLoaded extends SplitState {
  final List<SplitModel> splits;

  const SplitsLoaded(this.splits);
}

class SplitLoaded extends SplitState {
  final SplitModel split;

  const SplitLoaded(this.split);
}

class SplitTotalUpdated extends SplitState {
  final List<SplitModel> splits;
  const SplitTotalUpdated(this.splits);
}

class SplitError extends SplitState {
  final String message;

  const SplitError(this.message);
}

class SplitEdited extends SplitState {}

class SplitDeleted extends SplitState {
  final List<SplitModel> splits;

  const SplitDeleted(this.splits);

  @override
  List<Object?> get props => [splits];
}



// class FavouriteSplitLoading extends SplitState {}

// class FavouriteSplitSuccess extends SplitState {
//   final bool isFavourited;

//   const FavouriteSplitSuccess(this.isFavourited);
// }

// class FavouriteSplitFailure extends SplitState {
//   final String error;

//   FavouriteSplitFailure(this.error);
// }
