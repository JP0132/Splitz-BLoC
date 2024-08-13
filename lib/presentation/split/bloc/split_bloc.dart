// split_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/domain/usecases/create_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/delete_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/edit_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_all_splits_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_split_by_id_usecase.dart';
import 'split_state.dart';
import 'split_event.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  final CreateSplitUseCase createSplitUseCase;
  final GetAllSplitsUseCase getAllSplitsUseCase;
  final GetSplitByIdUsecase getSplitByIdUsecase;
  final EditSplitUsecase editSplitUsecase;
  final DeleteSplitUsecase deleteSplitUsecase;

  SplitBloc(
    this.createSplitUseCase,
    this.getAllSplitsUseCase,
    this.getSplitByIdUsecase,
    this.editSplitUsecase,
    this.deleteSplitUsecase,
  ) : super(SplitInitial()) {
    on<CreateSplitRequested>(_onCreateSplitRequested);
    on<FetchAllSplitRequested>(_onFetchAllSplitsRequested);
    on<FetchSplitByIdRequested>(_onFetchSplitByIdRequested);
    on<EditSplitRequested>(_onEditSplitRequested);
    on<DeleteSplitRequested>(_onDeleteSplitRequested);
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

  FutureOr<void> _onEditSplitRequested(
      EditSplitRequested event, Emitter<SplitState> emit) async {
    emit(SplitEditing());
    try {
      await editSplitUsecase(event.split);
      //add(FetchAllSplitRequested());
      emit(SplitEdited());
    } catch (e) {
      emit(SplitFailure(e.toString()));
    }
  }

  FutureOr<void> _onDeleteSplitRequested(
      DeleteSplitRequested event, Emitter<SplitState> emit) async {
    emit(SplitLoading());
    try {
      await deleteSplitUsecase(event.splitId);
      final splits = await getAllSplitsUseCase();
      emit(SplitsLoaded(splits));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }
}
