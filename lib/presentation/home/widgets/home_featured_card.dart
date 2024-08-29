import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/models/featured_card_data.dart';
import 'package:splitz_bloc/presentation/split/split.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/values.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class HomeFeaturedCard extends StatefulWidget {
  final List<FeaturedCardData> dataList;
  final String text;

  const HomeFeaturedCard(
      {super.key, required this.dataList, required this.text});

  @override
  State<HomeFeaturedCard> createState() => _HomeFeaturedCardState();
}

class _HomeFeaturedCardState extends State<HomeFeaturedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColours.darkSurface,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.text),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.dataList.length,
                  itemBuilder: (context, index) {
                    final data = widget.dataList[index];
                    return GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            gradient:
                                Helperfunctions.getColourByName(data.colour),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            child:
                                Icon(Helperfunctions.getIconByName(data.icon)),
                          ),
                        ),
                        title: Text(data.name),
                        subtitle: Text("\$${data.value.toString()}"),
                        trailing: Text(
                          Helperfunctions.getDateFormat(data.dateCreated),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
