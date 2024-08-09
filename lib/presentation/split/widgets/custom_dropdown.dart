import 'package:flutter/material.dart';
import 'package:splitz_bloc/models/currency.dart';
import 'package:splitz_bloc/models/icon_item.dart';
import 'package:splitz_bloc/models/split_colour.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class Customdropdown extends StatefulWidget {
  final String dropListName;
  final List<dynamic> values;
  final dynamic selectedValue;
  final Function(dynamic) onValueChanged;
  const Customdropdown(
      {super.key,
      required this.dropListName,
      required this.values,
      required this.onValueChanged,
      this.selectedValue});

  @override
  State<Customdropdown> createState() => _CustomdropdownState();
}

class _CustomdropdownState extends State<Customdropdown> {
  dynamic dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Helperfunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          isExpanded: true,
          hint: Text(
            widget.dropListName,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          value: dropdownValue,
          underline: null,
          onChanged: (dynamic newValue) {
            setState(() {
              dropdownValue = newValue;
            });
            widget.onValueChanged(newValue);
          },
          items: widget.values.map<DropdownMenuItem<dynamic>>((dynamic value) {
            if (value is String) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()), // Convert value to string
              );
            } else if (value is SplitColour) {
              return DropdownMenuItem<dynamic>(
                value: value.name,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: value.colour as LinearGradient?,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      value.name,
                    ),
                  ],
                ), // Convert value to string
              );
            } else if (value is IconItem) {
              return DropdownMenuItem<dynamic>(
                value: value.name,
                child: Row(
                  children: [
                    Icon(value.icon),
                  ],
                ),
              );
            } else if (value is Currency) {
              return DropdownMenuItem<dynamic>(
                value: value.name,
                child: Row(
                  children: [
                    Text(value.name),
                  ],
                ),
              );
            } else {
              throw ArgumentError(
                  'Invalid type for dropdown item: ${value.runtimeType}');
            }
          }).toList(),
        ),
      ),
    );
  }
}
