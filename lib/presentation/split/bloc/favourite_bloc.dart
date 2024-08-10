// split_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/domain/usecases/check_favourite_status_usecase.dart';
import 'package:splitz_bloc/domain/usecases/favourite_split_usecase.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteSplitUsecase favouriteSplitUsecase;
  final CheckFavouriteStatusUsecase checkFavouriteStatusUsecase;

  FavouriteBloc(
    this.favouriteSplitUsecase,
    this.checkFavouriteStatusUsecase,
  ) : super(FavouriteInitial()) {
    on<FavouriteSplitRequested>(_onFavouriteSplitRequested);
    on<CheckFavouriteStatusRequested>(_onCheckFavouriteStatusRequested);
  }

  FutureOr<void> _onFavouriteSplitRequested(
      FavouriteSplitRequested event, Emitter<FavouriteState> emit) async {
    try {
      emit(FavouriteLoading());
      await favouriteSplitUsecase(event.splitId, event.userId);
      emit(const FavouriteSuccess(true));
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  FutureOr<void> _onCheckFavouriteStatusRequested(
      CheckFavouriteStatusRequested event, Emitter<FavouriteState> emit) async {
    try {
      emit(FavouriteLoading());

      final existingFav = await checkFavouriteStatusUsecase(
        event.splitId,
        event.userId,
      );

      emit(FavouriteSuccess(existingFav));
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }
}
