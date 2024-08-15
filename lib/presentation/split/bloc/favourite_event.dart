import 'package:equatable/equatable.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class FavouriteSplitRequested extends FavouriteEvent {
  final String splitId;
  final String userId;

  const FavouriteSplitRequested(this.splitId, this.userId);

  @override
  List<Object> get props => [splitId, userId];
}

class CheckFavouriteStatusRequested extends FavouriteEvent {
  final String splitId;
  final String userId;

  const CheckFavouriteStatusRequested(this.splitId, this.userId);

  @override
  List<Object> get props => [splitId, userId];
}

class FetchFavouritedSplitRequest extends FavouriteEvent {}
