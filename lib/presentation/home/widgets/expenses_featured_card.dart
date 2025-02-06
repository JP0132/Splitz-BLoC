import 'package:flutter/material.dart';
import 'package:splitz_bloc/models/featured_card_data.dart';
import 'package:splitz_bloc/presentation/onboarding/on_boarding_page.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class ExpensesFeaturedCard extends StatefulWidget {
  final List<FeaturedCardData> dataList;
  final String text;

  const ExpensesFeaturedCard(
      {super.key, required this.dataList, required this.text});

  @override
  State<ExpensesFeaturedCard> createState() => _ExpensesFeaturedCardState();
}

class _ExpensesFeaturedCardState extends State<ExpensesFeaturedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColours.darkSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(widget.text),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.dataList.length,
                itemBuilder: (context, index) {
                  final data = widget.dataList[index];
                  final date =
                      Helperfunctions.getTextDateFormat(data.dateCreated);
                  String year = date.split('-')[0];
                  String month = date.split('-')[1];
                  String day = date.split('-')[2];
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: CustomColours.darkOnPrimary,
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: [
                          Text(
                            month,
                            style:
                                TextStyle(color: Colors.grey[400], fontSize: 6),
                          ),
                          Text(
                            day,
                            style: TextStyle(color: CustomColours.darkSurface),
                          ),
                          Text(
                            month,
                            style: TextStyle(color: CustomColours.darkSurface),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '\$${data.value.toString()}',
                      style: const TextStyle(
                        color: CustomColours.darkOnPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
