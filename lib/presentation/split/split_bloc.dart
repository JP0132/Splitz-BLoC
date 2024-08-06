// split_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/domain/usecases/create_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_all_splits_usecase.dart';
import 'split_state.dart';
import 'split_event.dart';

class SplitBloc extends Bloc<SplitEvent, SplitState> {
  final CreateSplitUseCase createSplitUseCase;
  final GetAllSplitsUseCase getAllSplitsUseCase;

  SplitBloc(this.createSplitUseCase, this.getAllSplitsUseCase)
      : super(SplitInitial()) {
    on<CreateSplitRequested>(_onCreateSplitRequested);
    on<FetchAllSplitRequested>(_onFetchAllSplitsRequested);
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
      emit(SplitLoaded(splits));
    } catch (e) {
      emit(SplitError(e.toString()));
    }
  }
}
