import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class SettingCards extends StatelessWidget {
  final String title;
  final String subtitle;
  final dynamic trailing;
  final Icon leading;
  final VoidCallback onTap;

  const SettingCards({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: CustomColours.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
