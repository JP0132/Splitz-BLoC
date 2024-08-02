import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.isDark,
    required this.hint,
  });

  final bool isDark;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: Helperfunctions.getScreenWidth(context),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
              color: isDark
                  ? CustomColours.darkOnSurface
                  : CustomColours.lightOnSurface),
        ),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 24,
              color: Colors.grey.shade600,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              hint,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            )
          ],
        ),
      ),
    );
  }
}
