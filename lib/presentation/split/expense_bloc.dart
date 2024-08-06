import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/domain/usecases/add_expense_usecase.dart';
import 'package:splitz_bloc/domain/usecases/delete_expense_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_expenses_for_split_usecase.dart';
import 'package:splitz_bloc/presentation/split/expense_event.dart';
import 'package:splitz_bloc/presentation/split/expense_state.dart';

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
      // final expenses = await getExpensesforSplitUseCase(event.splitId);
      // emit(ExpensesLoaded(expenses));
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
      final expenses = await getExpensesforSplitUseCase(event.splitId);
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
