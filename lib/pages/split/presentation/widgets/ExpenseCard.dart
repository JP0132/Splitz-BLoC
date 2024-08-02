import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/pages/split/data/models/expense_model.dart';
import 'package:splitz_bloc/pages/split/presentation/widgets/TagWidget.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expenseDetails;
  const ExpenseCard({
    super.key,
    required this.expenseDetails,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Helperfunctions.isDarkMode(context);
    String expenseID = expenseDetails.id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: Key(expenseID),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.green,
              icon: FontAwesomeIcons.pencil,
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              icon: FontAwesomeIcons.trash,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isDark ? CustomColours.darkSurface : CustomColours.lightSurface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    expenseDetails.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Helperfunctions.getDateFormat(expenseDetails.dateTime),
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
                    'Cost: \$${expenseDetails.cost}',
                    style: TextStyle(),
                  ),
                  Text(
                    'Paid: \$${expenseDetails.paid}',
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
                  Text("Type: ${expenseDetails.type}"),
                ],
              ),
              Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: expenseDetails.tags
                      .map((tag) => TagWidget(label: tag))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
