import 'package:equatable/equatable.dart';
import 'package:splitz_bloc/data/models/split_model.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object?> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final bool isFavourited;

  const FavouriteSuccess(this.isFavourited);
}

class FavouriteLoaded extends FavouriteState {
  final SplitModel? favouriteSplit;
  const FavouriteLoaded(this.favouriteSplit);
}

class FavouriteFailure extends FavouriteState {
  final String error;

  const FavouriteFailure(this.error);
}
