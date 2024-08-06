import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class WOnboarding extends StatelessWidget {
  const WOnboarding({
    super.key,
    required this.image,
    required this.title,
    required this.subText,
  });

  final String image, title, subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            width: Helperfunctions.screenWidth(context) * 0.8,
            height: Helperfunctions.screenHeight(context) * 0.6,
            image,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            subText,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
