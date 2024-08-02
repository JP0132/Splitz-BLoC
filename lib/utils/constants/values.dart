import 'package:flutter/material.dart';
import 'package:splitz_bloc/models/currency.dart';
import 'package:splitz_bloc/models/icon_item.dart';
import 'package:splitz_bloc/models/split_colour.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class CustomValues {
  static List<String> categories = [
    "Holiday",
    "Shopping",
    "Personal",
    "Work",
    "Food & Dining",
    "Entertainment"
  ];

  static List<IconItem> iconList = [
    IconItem(name: "Work", icon: Icons.work),
    IconItem(name: "Holiday", icon: Icons.beach_access),
    IconItem(name: "Rersonal", icon: Icons.person),
    IconItem(name: "Food & Dining", icon: Icons.dining),
    IconItem(name: "Shopping", icon: Icons.shopping_bag),
    IconItem(name: "Entertainment", icon: Icons.tv),
  ];

  static List<SplitColour> colours = [
    SplitColour(name: "Blue", colour: CustomColours.blueGradient),
    SplitColour(name: "Yellow", colour: CustomColours.yellowGradient),
    SplitColour(name: "Red", colour: CustomColours.redGradient),
    SplitColour(name: "Green", colour: CustomColours.greenGradient),
    SplitColour(name: "Purple", colour: CustomColours.purpleGradient)
  ];

  static List<Currency> currencies = [
    Currency(name: "GBP", symbol: "£"),
    Currency(name: "USD", symbol: "\$"),
    Currency(name: "EUR", symbol: "€"),
  ];

  static List<String> types = [
    "card",
    "cash",
    "bank transfer",
  ];

  // static List<CardTracker> cardItemsData = [
  //   CardTracker(
  //     totalAmount: 5654.0,
  //     createdAt: DateTime.now(),
  //     listName: "Holiday 1",
  //   ),
  //   CardTracker(
  //     totalAmount: 464.0,
  //     createdAt: DateTime.now(),
  //     listName: "Shopping Trip 2",
  //   ),
  //   CardTracker(
  //     totalAmount: 464.0,
  //     createdAt: DateTime.now(),
  //     listName: "Shopping Trip 2",
  //   ),
  //   CardTracker(
  //     totalAmount: 464.0,
  //     createdAt: DateTime.now(),
  //     listName: "Shopping Trip 2",
  //   ),
  //   CardTracker(
  //     totalAmount: 464.0,
  //     createdAt: DateTime.now(),
  //     listName: "Shopping Trip 2",
  //   ),
  // ];
}
