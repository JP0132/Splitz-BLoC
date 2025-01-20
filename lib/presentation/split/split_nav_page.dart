import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_state.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/split_card.dart';
import 'package:splitz_bloc/presentation/split/widgets/stat_card.dart';

class SplitNavPage extends StatefulWidget {
  const SplitNavPage({super.key});

  @override
  State<SplitNavPage> createState() => _SplitNavPageState();
}

// TODO: Close the previous sliders when a new one is opened
// DONE: Refersh the stats / recompute the stats when split is updated on callback
// TODO: Add filter
// TODO: Change UI layout

class _SplitNavPageState extends State<SplitNavPage> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<SplitModel>> _filteredSplitsNotifier = ValueNotifier([]);
  bool _refreshed = false; // Flag to check if data has been refreshed
  List<SplitModel> _splits = [];
  List<ExpenseModel> _expenses = [];
  List<Map<String, dynamic>> _stats = [];

  @override
  void initState() {
    super.initState();
    
    // Fetching the splits and expenses
    context.read<SplitBloc>().add(FetchAllSplitRequested());
    context.read<ExpenseBloc>().add(FetchAllUsersExpensesRequested());

    // Adding a listener to the search controller
    _searchController.addListener(_onSearchChanged);
  }

  // Fetching the splits and expenses back on refresh and setting the refreshed flag to true
  void _refreshData() {
    context.read<SplitBloc>().add(FetchAllSplitRequested());
    context.read<ExpenseBloc>().add(FetchAllUsersExpensesRequested());
    _refreshed = true;
  }

  void _onSearchChanged() {
    // No need to call setState here
    _filterSplits();
  }

  // Filter the splits based on the search query
  void _filterSplits() {
    String searchQuery = _searchController.text;
    List<SplitModel> filteredSplits;
    if (searchQuery.isEmpty) {
      filteredSplits = _splits;
    } else {
      filteredSplits = _splits.where((split) {
        final splitName = split.name.toLowerCase();
        return splitName.contains(searchQuery.toLowerCase());
      }).toList();
    }
    _filteredSplitsNotifier.value = filteredSplits;
  }

  @override
  void dispose() {
    // Dispose the search controller and remove the listener
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _filteredSplitsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Splits'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stat Cards (Separate BlocBuilder)
          BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, expenseState) {
              if (expenseState is ExpenseLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (expenseState is ExpensesLoaded) {
                _expenses = expenseState.expenses;
                return const SizedBox();
              } else if (expenseState is ExpenseError) {
                return Center(child: Text('Error: ${expenseState.message}'));
              } else {
                return const Center(child: Text('No expenses available.'));
              }
            },
          ),

          // Splits List (Separate BlocBuilder)
          Expanded(
            child: BlocBuilder<SplitBloc, SplitState>(
              builder: (context, state) {
                if (state is SplitLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SplitsLoaded) {
                  _splits = state.splits;
                  _filterSplits(); // Update the filtered splits
                  return ValueListenableBuilder<List<SplitModel>>(
                    valueListenable: _filteredSplitsNotifier,
                    builder: (context, filteredSplits, _) {
                      if (filteredSplits.isEmpty) {
                        return const Center(child: Text("No Splits found"));
                      } else {
                        _computeStats(_expenses);

                        return Column(
                          children: [
                            StatCardsLayoutWidget(stats: _stats),
                            // Splits List - used flexible to ensure renderflex error is avoided
                            Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                itemCount: filteredSplits.length,
                                itemBuilder: (context, index) {
                                  return SplitCard(
                                    split: filteredSplits[index],
                                    onCardTap: _refreshData,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                } else if (state is SplitError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No splits available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _computeStats(List<ExpenseModel> expenses) {
    // Only compute stats if they haven't been computed yet or if the data has been refreshed
    if (_stats.isEmpty || _refreshed) {

      // Set the refreshed flag to false
      _refreshed = false;

      // Getting the total spent of the combined values of the splits
      double totalSpent = _splits.fold(0.0, (sum, split) => sum + split.totalAmount);

      // Get the most expensive split
      SplitModel? mostExpensiveSplit = _splits.isNotEmpty ? _splits.first : null;

      // Get the most expensive expense
      ExpenseModel? mostExpensiveExpense = expenses.isNotEmpty ? expenses.first : null;

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
      List<MapEntry<String, int>> sortedTags = tagCounter.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Take the first 3 tags from sortedTags, map only the string value.
      // Add it to the list
      List<String> popularTags = sortedTags.take(3).map((entry) => entry.key).toList();

      // Get the most expensive split
      for (SplitModel split in _splits) {
        if (split.totalAmount >= mostExpensiveSplit!.totalAmount) {
          mostExpensiveSplit = split;
        }
      }

      // Get the most expensive expense
      for (ExpenseModel expense in expenses) {
        if (expense.paid >= mostExpensiveExpense!.paid) {
          mostExpensiveExpense = expense;
        }
      }

      _stats = [
        {
          'title': 'Total Spent',
          'value': totalSpent.toString(),
          'color': Colors.red,
          'icon': Icons.attach_money
        },
        {
          'title': 'Total Tags',
          'value': expenses.expand((e) => e.tags).toSet().length.toString(),
          'color': Colors.orange,
          'icon': Icons.label
        },
        {
          'title': 'Total Expenses',
          'value': expenses.fold(0.0, (sum, e) => sum + e.paid).toString(),
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
          'value': mostExpensiveExpense != null
              ? "${mostExpensiveExpense.name}: ${mostExpensiveExpense.paid}"
              : "N/A",
          'color': Colors.purple,
          'icon': Icons.money_off
        },
        {
          'title': 'Most Expensive Split',
          'value': "${mostExpensiveSplit?.name}: ${mostExpensiveSplit?.totalAmount}",
          'color': Colors.teal,
          'icon': Icons.show_chart
        },
      ];
    }
  }
}

// Separate Widget for Stat Cards
class StatCardsLayoutWidget extends StatelessWidget {
  final List<Map<String, dynamic>> stats;

  const StatCardsLayoutWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const Center(child: Text("Add Expenses to get stats"));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stats.map((stat) {
          return StatCard(
            stat: stat,
          );
        }).toList(),
      ),
    );
  }
}
