import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class FilterTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final String regFilter;
  final TextEditingController controller;
  final bool numberKeyBoard;
  const FilterTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    required this.regFilter,
    this.numberKeyBoard = false,
  });

  @override
  Widget build(BuildContext context) {
    border(Color colour) => OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 2),
          borderRadius: BorderRadius.circular(10),
        );
    return TextFormField(
      controller: controller,
      keyboardType: numberKeyBoard
          ? TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(regFilter))
      ],
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: border(Colors.grey.shade700),
        focusedBorder: border(CustomColours.darkPrimary),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }

        return null;
      },
    );
  }
}
