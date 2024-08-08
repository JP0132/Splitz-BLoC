import 'package:equatable/equatable.dart';

abstract class SplitEvent extends Equatable {
  const SplitEvent();

  @override
  List<Object> get props => [];
}

class CreateSplitRequested extends SplitEvent {
  final String name;
  final String category;
  final String currency;
  final String colour;

  const CreateSplitRequested(
      {required this.name,
      required this.category,
      required this.colour,
      required this.currency});

  @override
  List<Object> get props => [name, category, currency, colour];
}

class FetchAllSplitRequested extends SplitEvent {}

class UpdateSplitTotal extends SplitEvent {
  final double totalAmount;

  const UpdateSplitTotal({required this.totalAmount});

  @override
  List<Object> get props => [totalAmount];
}

class FetchSplitByIdRequested extends SplitEvent {
  final String splitId;

  const FetchSplitByIdRequested(this.splitId);

  @override
  List<Object> get props => [splitId];
}

class FavouriteSplitRequested extends SplitEvent {
  final String splitId;
  final String userId;

  const FavouriteSplitRequested(this.splitId, this.userId);

  @override
  List<Object> get props => [splitId, userId];
}
