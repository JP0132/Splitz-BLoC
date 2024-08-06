import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final LinearGradient? gradient;
  final Color? borderColor;
  final VoidCallback operation;
  const AuthButton(
      {super.key,
      required this.text,
      this.gradient,
      this.borderColor,
      required this.operation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 1),
        gradient: gradient ??
            const LinearGradient(colors: [
              CustomColours.darkPrimary,
              CustomColours.darkPrimaryVariant,
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: ElevatedButton(
        onPressed: operation,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )),
      ),
    );
  }
}
