import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/presentation/split/edit_expense.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_event.dart';
import 'package:splitz_bloc/presentation/split/widgets/tag_widget.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class ExpenseCard extends StatefulWidget {
  final ExpenseModel expenseDetails;
  const ExpenseCard({
    super.key,
    required this.expenseDetails,
  });

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Helperfunctions.isDarkMode(context);
    String expenseID = widget.expenseDetails.id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: Key(expenseID),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Builder(
              builder: (con) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditExpense(
                          expenseDetails: widget.expenseDetails,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(10)),
                  child: const Icon(
                    FontAwesomeIcons.pencil,
                    color: Colors.white,
                    size: 25,
                  ),
                );
              },
            ),
            Builder(
              builder: (con) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Split?"),
                        content: const Text(
                          "Are you sure you want to delete this expense, this action is irversiable",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<ExpenseBloc>().add(
                                  DeleteExpenseRequested(
                                      widget.expenseDetails));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Expense deleted successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "DELETE",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    // Call the callback when returning from SplitDetailPage
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(10)),
                  child: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                    size: 25,
                  ),
                );
              },
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (widget.expenseDetails.notes.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Notes"),
                  content: Text(widget.expenseDetails.notes),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDark
                  ? CustomColours.darkSurface
                  : CustomColours.lightSurface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.expenseDetails.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Helperfunctions.getDateFormat(
                          widget.expenseDetails.dateTime),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cost: ${Helperfunctions.getCurrencyFormat(widget.expenseDetails.currency)}${widget.expenseDetails.cost}',
                      style: TextStyle(),
                    ),
                    Text(
                      'Paid: ${Helperfunctions.getCurrencyFormat(widget.expenseDetails.currency)}${widget.expenseDetails.paid}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Type: ${widget.expenseDetails.type}"),
                  ],
                ),
                Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: widget.expenseDetails.tags
                        .map((tag) => TagWidget(label: tag))
                        .toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
