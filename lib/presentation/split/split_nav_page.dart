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
                    return Center(child: Text("No Expenses have been added"));
                  }

                  // Getting the total spent of the combined values of the splits
                  double totalSpent =
                      splits.fold(0.0, (sum, split) => sum + split.totalAmount);

                  // Get the most expensive split
                  SplitModel mostExpensiveSplit = splits[0];

                  // Get the most expensive expense
                  ExpenseModel mostExpensiveExpense = expenses[0];

                  // Most popular tags
                  List<String> popularTags = [];

                  // Number of tags
                  final numberOfTags = 0;

                  final expenseBloc = context.read<ExpenseBloc>();
                  String splitId;

                  // Get the most expensive split
                  for (SplitModel split in splits) {
                    if (split.totalAmount >= mostExpensiveSplit.totalAmount) {
                      mostExpensiveSplit = split;
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
                      'value': "54",
                      'color': Colors.orange,
                      'icon': Icons.label
                    },
                    {
                      'title': 'Total Expenses',
                      'value': "4830",
                      'color': Colors.green,
                      'icon': Icons.receipt
                    },
                    {
                      'title': 'Popular Tags',
                      'value': ["tourist", "food", "drink"],
                      'color': Colors.blue,
                      'icon': Icons.local_offer
                    },
                    {
                      'title': 'Most Expensive Expense',
                      'value':
                          "${mostExpensiveSplit.name}: ${mostExpensiveSplit.totalAmount}",
                      'color': Colors.purple,
                      'icon': Icons.money_off
                    },
                    {
                      'title': 'Most Expensive Split',
                      'value': "Split name: 34345",
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
                              return Container(
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(right: 8.0),
                                decoration: BoxDecoration(
                                  color: stat['color'],
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(stat['icon'],
                                              color: Colors.white, size: 24.0),
                                          SizedBox(width: 8.0),
                                          Text(
                                            stat['title']!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      if (stat['value'] is List<String>)
                                        Wrap(
                                          spacing: 4.0,
                                          runSpacing: 4.0,
                                          children:
                                              (stat['value'] as List<String>)
                                                  .map((tag) {
                                            return Chip(
                                              label: Text(
                                                tag,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0),
                                              ),
                                              backgroundColor: Colors.black26,
                                            );
                                          }).toList(),
                                        )
                                      else
                                        Text(
                                          stat['value']!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: splits.length,
                            itemBuilder: (context, index) {
                              final split = splits[index];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: ListTile(
                                  title: Text(
                                    split.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Currency: ${split.currency}'),
                                  trailing: Text(
                                    '\$${split.totalAmount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (expenseState is ExpenseError) {
                  return Center(child: Text('Error: ${expenseState.message}'));
                } else {
                  return Center(child: Text('No expenses available.'));
                }
              });
            }
          } else if (state is SplitError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No splits available.'));
          }
        },
      ),
    );
  }
}
