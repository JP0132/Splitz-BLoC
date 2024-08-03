import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    border(Color colour) => OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 2),
          borderRadius: BorderRadius.circular(10),
        );
    return TextFormField(
      controller: controller,
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
