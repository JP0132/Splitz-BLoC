import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/presentation/home/widgets/featured_split.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/split/add_new_expense.dart';
import 'package:splitz_bloc/presentation/split/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/expense_event.dart';
import 'package:splitz_bloc/presentation/split/expense_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/ExpenseCard.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class SplitPage extends StatefulWidget {
  final SplitModel splitDetails;
  const SplitPage({super.key, required this.splitDetails});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  String _searchQuery = '';
  List<ExpenseModel> _filteredExpenses = [];
  List<ExpenseModel> _expenses = [];
  late double _totalSpent;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<ExpenseBloc>()
        .add(FetchExpensesRequested(widget.splitDetails.id));
    _searchController.addListener(_onSearchChanged);
    _totalSpent = widget.splitDetails.totalAmount;
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterExpenses();
    });
  }

  void _filterExpenses() {
    List<String> searchTerms = _searchQuery
        .split(',')
        .map((term) => term.trim().toLowerCase())
        .toList();

    if (_searchQuery.isEmpty) {
      _filteredExpenses = _expenses;
    } else {
      _filteredExpenses = _expenses.where((expense) {
        final expenseNameLower = expense.name.toLowerCase();
        // final searchQueryLower = _searchQuery.toLowerCase();

        final tagsLower = expense.tags.map((tag) => tag.toLowerCase()).toList();
        return searchTerms.any((term) =>
            expenseNameLower.contains(term) ||
            tagsLower.any((tag) => tag.contains(term)));
      }).toList();
    }
    if (_filteredExpenses.isNotEmpty) {
      _calculateTotalSpent();
    } else {
      // Keep the initial total amount if the filter yields no results
      _totalSpent = widget.splitDetails.totalAmount;
    }
  }

  void _updateTotalSpent(double newTotal) {
    // Schedule the setState to happen after the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _totalSpent = newTotal;
        });
      }
    });
  }

  void _calculateTotalSpent() {
    _totalSpent =
        _filteredExpenses.fold(0.0, (sum, expense) => sum + expense.paid);
    _updateTotalSpent(_totalSpent);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Helperfunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColours.darkPrimary,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddNewExpense(splitDetails: widget.splitDetails))),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 0, left: 15),
              child: FeaturedSplit(
                splitDetails: widget.splitDetails,
                totalAmount: _totalSpent,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : CustomColours.lightOnSurface.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Search, use commas for multi search',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ExpensesLoaded) {
                  _expenses = state.expenses;
                  _filterExpenses();
                  print("ahahahahahahahahahahahahahahah" +
                      _totalSpent.toString());

                  if (_filteredExpenses.isEmpty) {
                    return const Center(child: Text('No expenses available.'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 8, left: 8, bottom: 100),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredExpenses.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final expense = _filteredExpenses[index];
                            return ExpenseCard(
                              expenseDetails: expense,
                            );
                          }),
                    );
                  }
                } else if (state is ExpenseError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No splits available.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
