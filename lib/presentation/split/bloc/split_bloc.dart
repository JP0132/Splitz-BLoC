// split_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/domain/usecases/check_favourite_status_usecase.dart';
import 'package:splitz_bloc/domain/usecases/create_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/favourite_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_all_splits_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_split_by_id_usecase.dart';
import 'split_state.dart';
import 'split_event.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  final CreateSplitUseCase createSplitUseCase;
  final GetAllSplitsUseCase getAllSplitsUseCase;
  final GetSplitByIdUsecase getSplitByIdUsecase;
  // final FavouriteSplitUsecase favouriteSplitUsecase;
  // final CheckFavouriteStatusUsecase checkIfFavSplitUsecase;

  SplitBloc(
    this.createSplitUseCase,
    this.getAllSplitsUseCase,
    this.getSplitByIdUsecase,
  ) : super(SplitInitial()) {
    on<CreateSplitRequested>(_onCreateSplitRequested);
    on<FetchAllSplitRequested>(_onFetchAllSplitsRequested);
    on<FetchSplitByIdRequested>(_onFetchSplitByIdRequested);
    // on<FavouriteSplitRequested>(_onFavouriteSplitRequested);
    // on<CheckFavouriteStatusRequested>(_onCheckFavouriteStatusRequested);
  }

  void _onCreateSplitRequested(
    CreateSplitRequested event,
    Emitter<SplitState> emit,
  ) async {
    emit(SplitLoading());
    try {
      await createSplitUseCase(
          event.name, event.category, event.colour, event.currency);
      emit(SplitSuccess());
    } catch (e) {
      emit(SplitFailure(e.toString()));
    }
  }

  void _onFetchAllSplitsRequested(
      FetchAllSplitRequested event, Emitter<SplitState> emit) async {
    emit(SplitLoading());
    try {
      final splits = await getAllSplitsUseCase();
      emit(SplitsLoaded(splits));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  FutureOr<void> _onFetchSplitByIdRequested(
      FetchSplitByIdRequested event, Emitter<SplitState> emit) async {
    emit(SplitLoading());
    try {
      final split = await getSplitByIdUsecase(event.splitId);
      emit(SplitLoaded(split));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }

  // FutureOr<void> _onFavouriteSplitRequested(
  //     FavouriteSplitRequested event, Emitter<SplitState> emit) async {
  //   try {
  //     emit(FavouriteSplitLoading());
  //     await favouriteSplitUsecase(event.splitId, event.userId);
  //     emit(FavouriteSplitSuccess(true));
  //   } catch (e) {
  //     emit(FavouriteSplitFailure(e.toString()));
  //   }
  // }

  // FutureOr<void> _onCheckFavouriteStatusRequested(
  //     CheckFavouriteStatusRequested event, Emitter<SplitState> emit) async {
  //   try {
  //     emit(FavouriteSplitLoading());

  //     final existingFav = await checkIfFavSplitUsecase(
  //       event.splitId,
  //       event.userId,
  //     );

  //     emit(FavouriteSplitSuccess(true));
  //   } catch (e) {
  //     emit(FavouriteSplitFailure(e.toString()));
  //   }
  // }
}
