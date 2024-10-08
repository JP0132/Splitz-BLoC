import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/split/split.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/values.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class ExpandedBoxList extends StatefulWidget {
  final List<SplitModel> splits;

  const ExpandedBoxList({super.key, required this.splits});

  @override
  State<ExpandedBoxList> createState() => _ExpandedBoxListState();
}

class _ExpandedBoxListState extends State<ExpandedBoxList> {
  bool _expanded = false;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final bool? result = ModalRoute.of(context)?.settings.arguments as bool?;
  //   if (result == true) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (mounted) {
  //         print("Fetching splits...");
  //         context.read<SplitBloc>().add(FetchAllSplitRequested());
  //       }
  //     });
  //   }
  // }

  IconData? getIconByName(String name) {
    for (var item in CustomValues.iconList) {
      if (item.name == name) {
        return item.icon;
      }
    }
    return null; // Return null if the name is not found
  }

  Gradient? getColourByName(String name) {
    for (var item in CustomValues.colours) {
      if (item.name == name) {
        return item.colour;
      }
    }
    return null;
  }

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
              padding: const EdgeInsets.only(right: 15.0, top: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_expanded) {
                        _expanded = false;
                      } else {
                        _expanded = true;
                      }
                    });
                  },
                  child: !_expanded
                      ? FaIcon(
                          FontAwesomeIcons.arrowDown,
                        )
                      : FaIcon(FontAwesomeIcons.arrowUp),
                ),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _expanded
                    ? widget.splits.length
                    : (widget.splits.length > 2 ? 3 : widget.splits.length),
                itemBuilder: (context, index) {
                  final split = widget.splits[index];
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplitPage(splitDetails: split),
                        ),
                      );
                      // Reload the splits if the result is true
                      print("Navigation result: $result");
                      if (result == true) {
                        print("Mounted result: $mounted");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            print("Fetching splits...");
                            context
                                .read<SplitBloc>()
                                .add(FetchAllSplitRequested());
                          } else {
                            print("The widget is not mounted.");
                          }
                        });
                      }
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          gradient: getColourByName(split.colour) ??
                              const LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.black,
                                ],
                              ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          child: Icon(
                              getIconByName(split.category) ?? Icons.error),
                        ),
                      ),
                      title: Text(split.name),
                      subtitle: Text("\$${split.totalAmount.toString()}"),
                      trailing: Text(
                        Helperfunctions.getDateFormat(split.dateTime),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
