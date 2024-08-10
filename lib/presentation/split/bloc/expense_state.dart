import 'package:equatable/equatable.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseSuccess extends ExpenseState {}

class ExpenseFailure extends ExpenseState {
  final String message;

  const ExpenseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpenseAdded extends ExpenseState {}

class ExpenseEdited extends ExpenseState {}

class ExpenseDeleted extends ExpenseState {
  final List<ExpenseModel> expenses;

  const ExpenseDeleted(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpensesLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;

  const ExpensesLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
