import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/AddExpenseUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/DeleteExpenseUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/GetExpensesForSplitUseCase.dart';
import 'package:splitz_bloc/pages/split/presentation/expense_event.dart';
import 'package:splitz_bloc/pages/split/presentation/expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AddExpenseUseCase addExpenseUseCase;
  final GetExpensesforSplitUseCase getExpensesforSplitUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  ExpenseBloc(this.addExpenseUseCase, this.getExpensesforSplitUseCase,
      this.deleteExpenseUseCase)
      : super(ExpenseInitial()) {
    on<AddExpenseRequested>(_onAddExpenseRequested);
    on<FetchExpensesRequested>(_onFetchExpensesRequested);
    on<DeleteExpenseRequested>(_onDeleteExpenseRequested);
  }

  void _onAddExpenseRequested(
      AddExpenseRequested event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      await addExpenseUseCase(event.expense);
      add(FetchExpensesRequested(event.expense.splitId));
      emit(ExpenseAdded());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  void _onFetchExpensesRequested(
      FetchExpensesRequested event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      final expenses = await getExpensesforSplitUseCase(event.splitId);
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  void _onDeleteExpenseRequested(
      DeleteExpenseRequested event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      await deleteExpenseUseCase(event.expenseId);
      emit(ExpenseDeleted());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
