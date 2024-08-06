import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    required this.isDark,
    required this.divderText,
  });

  final bool isDark;
  final String divderText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            thickness: 0.7,
            indent: 40,
            endIndent: 5,
          ),
        ),
        Text(divderText,
            style: TextStyle(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400)),
        Flexible(
          child: Divider(
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            thickness: 0.7,
            indent: 5,
            endIndent: 40,
          ),
        ),
      ],
    );
  }
}
