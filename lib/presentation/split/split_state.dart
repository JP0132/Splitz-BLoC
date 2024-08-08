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
  SplitTotalUpdated(this.splits);
}

class SplitError extends SplitState {
  final String message;

  SplitError(this.message);
}

class SplitFavourited extends SplitState {}
