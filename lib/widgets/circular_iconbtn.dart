import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class CircularIconbtn extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CircularIconbtn({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              backgroundColor: CustomColours.darkPrimary.withOpacity(0.5)),
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        ),
        Text(
          text,
        )
      ],
    );
  }
}
