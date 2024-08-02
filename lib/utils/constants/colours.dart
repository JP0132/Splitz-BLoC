import 'package:flutter/material.dart';

class CustomColours {
  CustomColours._();
  // Dark Theme Colours
  static const Color darkPrimary = Color.fromRGBO(80, 127, 229, 1);
  static const Color darkPrimaryVariant = Color.fromRGBO(1, 29, 91, 1);
  static const Color darkSecondary = Color.fromRGBO(50, 53, 61, 1);

  static const Color darkError = Color.fromRGBO(240, 97, 109, 1);
  static const Color darkSuccess = Color.fromRGBO(39, 173, 117, 1);

  static const Color darkBackground = Color.fromRGBO(10, 11, 13, 1);
  static const Color darkSurface = Color(0xFF242424);

  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnError = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);

  // Light Theme Colours
  static const Color lightPrimary = Color.fromRGBO(80, 127, 229, 1);
  static const Color lightPrimaryVariant = Color.fromRGBO(1, 29, 91, 1);
  static const Color lightSecondary = Color.fromRGBO(50, 53, 61, 1);

  static const Color lightError = Color(0xFFB00020);
  static const Color lightBackground = Color.fromARGB(196, 255, 255, 255);
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);

  // Gradient Colours
  static const Color blue = Color(0xFF0b2447);
  static const Color blue2 = Color(0xFF19376d);
  static const Color blue3 = Color(0xFF576CBC);

  static const Color red = Color(0xFF470B0B);
  static const Color red2 = Color(0xFF6D1919);
  static const Color red3 = Color(0xFFBC5757);

  static const Color green = Color.fromARGB(255, 17, 71, 11);
  static const Color green2 = Color.fromARGB(255, 29, 109, 25);
  static const Color green3 = Color.fromARGB(255, 92, 188, 87);

  static const Color yellow = Color.fromARGB(255, 69, 71, 11);
  static const Color yellow2 = Color.fromARGB(255, 105, 109, 25);
  static const Color yellow3 = Color.fromARGB(255, 188, 188, 87);

  static const Color purple = Color.fromARGB(255, 47, 11, 71);
  static const Color purple2 = Color.fromARGB(255, 67, 25, 109);
  static const Color purple3 = Color.fromARGB(255, 149, 87, 188);

  static const Gradient blueGradient = LinearGradient(
    colors: [blue3, blue],
    stops: [0, 1],
    begin: AlignmentDirectional(0.94, -1),
    end: AlignmentDirectional(-0.94, 1),
  );

  static const Gradient redGradient = LinearGradient(
    colors: [red3, red],
    stops: [0, 1],
    begin: AlignmentDirectional(0.94, -1),
    end: AlignmentDirectional(-0.94, 1),
  );

  static const Gradient greenGradient = LinearGradient(
    colors: [green3, green],
    stops: [0, 1],
    begin: AlignmentDirectional(0.94, -1),
    end: AlignmentDirectional(-0.94, 1),
  );

  static const Gradient yellowGradient = LinearGradient(
    colors: [yellow3, yellow],
    stops: [0, 1],
    begin: AlignmentDirectional(0.94, -1),
    end: AlignmentDirectional(-0.94, 1),
  );

  static const Gradient purpleGradient = LinearGradient(
    colors: [purple3, purple],
    stops: [0, 1],
    begin: AlignmentDirectional(0.94, -1),
    end: AlignmentDirectional(-0.94, 1),
  );
}
