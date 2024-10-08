import 'package:equatable/equatable.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class AddExpenseRequested extends ExpenseEvent {
  final ExpenseModel expense;

  const AddExpenseRequested(this.expense);

  @override
  List<Object?> get props => [expense];
}

class FetchExpensesRequested extends ExpenseEvent {
  final String splitId;

  const FetchExpensesRequested(this.splitId);

  @override
  List<Object?> get props => [splitId];
}

class FetchAllUsersExpensesRequested extends ExpenseEvent {}

class DeleteExpenseRequested extends ExpenseEvent {
  final ExpenseModel expense;

  const DeleteExpenseRequested(this.expense);

  @override
  List<Object?> get props => [expense];
}

class EditExpenseRequested extends ExpenseEvent {
  final ExpenseModel expense;

  const EditExpenseRequested(this.expense);

  @override
  List<Object?> get props => [expense];
}
