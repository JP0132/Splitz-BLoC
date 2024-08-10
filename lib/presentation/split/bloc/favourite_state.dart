import 'package:equatable/equatable.dart';

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
  const FavouriteLoaded();
}

class FavouriteFailure extends FavouriteState {
  final String error;

  FavouriteFailure(this.error);
}
