import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/usecases/get_all_expenses_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_expenses_for_split_usecase.dart';
import 'package:splitz_bloc/presentation/home/widgets/expanded_box_list.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_state.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/split_card.dart';
import 'package:splitz_bloc/presentation/split/widgets/stat_card.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class SplitNavPage extends StatefulWidget {
  const SplitNavPage({super.key});

  @override
  State<SplitNavPage> createState() => _SplitNavPageState();
}

class _SplitNavPageState extends State<SplitNavPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplitBloc>().add(FetchAllSplitRequested());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This method is called when the page comes back into view.
    // Ensure the splits are refetched every time the page is shown.
    context.read<SplitBloc>().add(FetchAllSplitRequested());
  }

  void _refreshData() {
    context.read<SplitBloc>().add(FetchAllSplitRequested());
    context.read<ExpenseBloc>().add(FetchAllUsersExpensesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Splits'),
        centerTitle: true,
      ),

      // Fetching the splits first
      body: BlocBuilder<SplitBloc, SplitState>(
        builder: (context, state) {
          // If splits are still fetching then show loading circle
          if (state is SplitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SplitsLoaded) {
            // Splits are now fetched
            if (state.splits.isEmpty) {
              return const Center(child: Text("No Splits have been created"));
            } else {
              final expenseBloc = context.read<ExpenseBloc>();
              expenseBloc.add(FetchAllUsersExpensesRequested());
              return BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, expenseState) {
                if (expenseState is ExpenseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (expenseState is ExpensesLoaded) {
                  // Saving the fetched values
                  final expenses = expenseState.expenses;
                  final splits = state.splits;

                  if (expenses.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Add Expenses to get stats"),
                          const SizedBox(height: 16.0),
                          SplitCard(
                            splits: splits,
                            onCardTap: _refreshData,
                          ),
                        ],
                      ),
                    );
                  }

                  // Getting the total spent of the combined values of the splits
                  double totalSpent =
                      splits.fold(0.0, (sum, split) => sum + split.totalAmount);

                  // Get the most expensive split
                  SplitModel mostExpensiveSplit = splits[0];

                  // Get the most expensive expense
                  ExpenseModel mostExpensiveExpense = expenses[0];

                  // Map to store the counts of each tag
                  Map<String, int> tagCounter = {};

                  // Loop through each tag list and increment a counter each time it is used
                  for (ExpenseModel expense in expenses) {
                    for (String tag in expense.tags) {
                      if (tagCounter.containsKey(tag)) {
                        tagCounter[tag] = tagCounter[tag]! + 1;
                      } else {
                        tagCounter[tag] = 1;
                      }
                    }
                  }

                  // Convert the map entries (tag, count) to a list and
                  // sort it in descending order by the count value
                  List<MapEntry<String, int>> sortedTags = tagCounter.entries
                      .toList()
                    ..sort((a, b) => b.value.compareTo(a.value));

                  // List<MapEntry<String, int>> topThreeTags =
                  //     sortedTags.take(3).toList();

                  // Take the first 3 tags from sortedTags, map only the string value.
                  // Add it to the list
                  List<String> popularTags =
                      sortedTags.take(3).map((entry) => entry.key).toList();
                  // Get the most expensive split
                  for (SplitModel split in splits) {
                    if (split.totalAmount >= mostExpensiveSplit.totalAmount) {
                      mostExpensiveSplit = split;
                    }
                  }

                  // Get the most expensive expense
                  for (ExpenseModel expense in expenses) {
                    if (expense.paid >= mostExpensiveExpense.paid) {
                      mostExpensiveExpense = expense;
                    }
                  }

                  List<Map<String, dynamic>> stats = [
                    {
                      'title': 'Total Spent',
                      'value': totalSpent.toString(),
                      'color': Colors.red,
                      'icon': Icons.attach_money
                    },
                    {
                      'title': 'Total Tags',
                      'value': expenses
                          .expand((e) => e.tags)
                          .toSet()
                          .length
                          .toString(),
                      'color': Colors.orange,
                      'icon': Icons.label
                    },
                    {
                      'title': 'Total Expenses',
                      'value': expenses
                          .fold(0.0, (sum, e) => sum + e.paid)
                          .toString(),
                      'color': Colors.green,
                      'icon': Icons.receipt
                    },
                    {
                      'title': 'Popular Tags',
                      'value': popularTags,
                      'color': Colors.blue,
                      'icon': Icons.local_offer
                    },
                    {
                      'title': 'Most Expensive Expense',
                      'value':
                          "${mostExpensiveExpense.name}: ${mostExpensiveExpense.paid}",
                      'color': Colors.purple,
                      'icon': Icons.money_off
                    },
                    {
                      'title': 'Most Expensive Split',
                      'value':
                          "${mostExpensiveSplit.name}: ${mostExpensiveSplit.totalAmount}",
                      'color': Colors.teal,
                      'icon': Icons.show_chart
                    },
                  ];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: stats.map((stat) {
                              return StatCard(
                                stat: stat,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SplitCard(
                          splits: splits,
                          onCardTap: _refreshData,
                        ),
                      ],
                    ),
                  );
                } else if (expenseState is ExpenseError) {
                  return Center(child: Text('Error: ${expenseState.message}'));
                } else {
                  return const Center(child: Text('No expenses available.'));
                }
              });
            }
          } else if (state is SplitError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No splits available.'));
          }
        },
      ),
    );
  }
}
