import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_button.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_field.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/custom_dropdown.dart';
import 'package:splitz_bloc/presentation/split/widgets/custom_date_picker.dart';
import 'package:splitz_bloc/presentation/split/widgets/custom_tag_field.dart';
import 'package:splitz_bloc/presentation/split/widgets/filter_text_field.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/values.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class EditExpense extends StatefulWidget {
  final ExpenseModel expenseDetails;
  const EditExpense({super.key, required this.expenseDetails});

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  DateTime selectedDate = DateTime.now();
  late List<String> addedTags;

  late TextEditingController nameController;
  late TextEditingController paidController;
  late TextEditingController costController;
  late TextEditingController notesController;

  final String decimalOnlyRegExp = r'^(\d+)?\.?\d{0,2}';

  String selectedType = "";
  String selectedCurrency = "";

  @override
  void initState() {
    super.initState();
    // Initialize the controller with an initial value
    nameController = TextEditingController(text: widget.expenseDetails.name);
    paidController =
        TextEditingController(text: widget.expenseDetails.paid.toString());
    costController =
        TextEditingController(text: widget.expenseDetails.cost.toString());
    notesController = TextEditingController(text: widget.expenseDetails.notes);
    selectedType = widget.expenseDetails.type;
    selectedCurrency = widget.expenseDetails.currency;
    selectedDate = widget.expenseDetails.dateTime;
    addedTags = widget.expenseDetails.tags;
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    nameController.dispose();
    paidController.dispose();
    costController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void handleDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void handleTagsChanged(List<String> tags) {
    addedTags = tags;
    setState(() {
      addedTags = tags;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Helperfunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Edit the Expense",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
            Form(
                child: Column(
              children: [
                AuthField(
                  hintText: "Transaction Name",
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomDatePicker(
                  onDateChanged: handleDateChanged,
                  dateToEdit: widget.expenseDetails.dateTime,
                ),
                const SizedBox(
                  height: 16,
                ),
                Customdropdown(
                  dropListName: "Currency",
                  selectedValue: widget.expenseDetails.currency,
                  values: CustomValues.currencies,
                  onValueChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                FilterTextField(
                  hintText: "Cost",
                  controller: costController,
                  regFilter: decimalOnlyRegExp,
                  numberKeyBoard: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                FilterTextField(
                  hintText: "Paid",
                  controller: paidController,
                  regFilter: decimalOnlyRegExp,
                  numberKeyBoard: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Customdropdown(
                  dropListName: "Type",
                  selectedValue: widget.expenseDetails.type,
                  values: CustomValues.types,
                  onValueChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTagField(
                  onTagsChanged: handleTagsChanged,
                  addedTags: widget.expenseDetails.tags,
                ),
                const SizedBox(
                  height: 16,
                ),
                FilterTextField(
                  hintText: "Notes",
                  controller: notesController,
                  regFilter: ".*",
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocConsumer<ExpenseBloc, ExpenseState>(
                  listener: (context, state) {
                    if (state is ExpenseEdited) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Expense edited successfully!'),
                        backgroundColor: CustomColours.darkSuccess,
                      ));
                      Navigator.pop(context);
                    } else if (state is ExpenseFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Failed to edit expense: ${state.message}'),
                        backgroundColor: CustomColours.darkError,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is ExpenseLoading) {
                      return const CircularProgressIndicator();
                    }
                    return AuthButton(
                      text: "Edit Expense",
                      operation: () {
                        final name = nameController.text;
                        final cost = costController.text;
                        final paid = paidController.text;
                        final notes = notesController.text;

                        if (name.isNotEmpty &&
                            cost.isNotEmpty &&
                            paid.isNotEmpty &&
                            selectedType != "" &&
                            selectedCurrency != "") {
                          ExpenseModel expenseModel = ExpenseModel(
                            name: name,
                            cost: double.parse(cost),
                            paid: double.parse(paid),
                            notes: notes,
                            tags: addedTags,
                            type: selectedType,
                            currency: selectedCurrency,
                            id: widget.expenseDetails.id,
                            splitId: widget.expenseDetails.splitId,
                            dateTime: selectedDate,
                          );

                          context
                              .read<ExpenseBloc>()
                              .add(EditExpenseRequested(expenseModel));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: CustomColours.darkError,
                                content: Text('Please fill in all fields')),
                          );
                        }
                      },
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade900],
                      ),
                    );
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
