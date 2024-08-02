import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static const Color darkGrey = Color(0xFF121212);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "JetBrains Mono",
    appBarTheme: AppBarTheme(backgroundColor: CustomColours.lightSurface),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light, // Define a base color or seed color
      primary: CustomColours.lightPrimary,
      secondary: CustomColours.lightSecondary,
      surface: CustomColours.lightSurface,
      error: CustomColours.lightError,
      onSurface: CustomColours.lightOnSurface,
      onPrimary: CustomColours.lightOnPrimary,
      onError: CustomColours.lightOnError,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "JetBrains Mono",
    appBarTheme: AppBarTheme(backgroundColor: CustomColours.darkBackground),
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColours.darkBackground,
      brightness: Brightness.dark, // Define a base color or seed color
      primary: CustomColours.darkPrimary,
      secondary: CustomColours.darkSecondary,
      surface: CustomColours.darkSurface,
      error: CustomColours.darkError,
      onSurface: CustomColours.darkOnSurface,
      onPrimary: CustomColours.darkOnPrimary,
      onError: CustomColours.darkOnError,
    ),
    scaffoldBackgroundColor: CustomColours.darkBackground,
  );
}
