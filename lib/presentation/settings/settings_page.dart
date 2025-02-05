import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splitz_bloc/presentation/settings/widgets/setting_cards.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.yellow, // Replace with actual image
                  radius: 30,
                ),
                SizedBox(width: 16.0),
                Text(
                  'User\'s Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SettingCards(
            title: "Apperance",
            subtitle: "Change apperance",
            leading: const Icon(Icons.color_lens, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () => {},
          ),
          const SizedBox(
            height: 20,
          ),
            SettingCards(
            title: "Account Details",
            subtitle: "View/edit account details",
            leading: const Icon(Icons.logout, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () => {},
          ),
          const SizedBox(
            height: 20,
          ),
          SettingCards(
            title: "Sign Out",
            subtitle: "Sign out of your account",
            leading: const Icon(Icons.logout, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () => {},
          ),

        ],
      ),
    );
  }
}
