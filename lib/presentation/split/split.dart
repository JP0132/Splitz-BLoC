import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    bool isDark = Helperfunctions.isDarkMode(context);
    String formattedDate =
        Helperfunctions.getDateFormat(widget.splitDetails.dateTime);
    String formattedAmount = "\$${widget.splitDetails.totalAmount.toString()}";

    context
        .read<ExpenseBloc>()
        .add(FetchExpensesRequested(widget.splitDetails.id));

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
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
                totalSpent: formattedAmount,
                dateCreated: formattedDate,
                listName: widget.splitDetails.name,
                colour:
                    Helperfunctions.getColourByName(widget.splitDetails.colour),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : CustomColours.lightOnSurface.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
                  final expenses = state.expenses;
                  if (expenses.isEmpty) {
                    return const Center(child: Text('No expenses available.'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: expenses.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
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
