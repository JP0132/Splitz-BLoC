import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:splitz_bloc/utils/constants/values.dart';

class Helperfunctions {
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomNavBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static String getDateFormat(DateTime date) {
    // Extract the date and reformat it
    DateTime currentDate = DateTime(
      date.year,
      date.month,
      date.day,
    );
    return DateFormat('yyyy-MM-dd').format(currentDate);
  }

  static IconData? getIconByName(String name) {
    for (var item in CustomValues.iconList) {
      if (item.name == name) {
        return item.icon;
      }
    }
    return null; // Return null if the name is not found
  }

  static Gradient getColourByName(String name) {
    for (var item in CustomValues.colours) {
      if (item.name == name) {
        return item.colour;
      }
    }
    return const LinearGradient(
      colors: [
        Colors.black,
        Colors.black,
      ],
    );
  }
}
