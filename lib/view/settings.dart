import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class Settings extends StatelessWidget {
  static const String id = "websettings";

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return Scaffold(
          body: ListView(
            children: [
              SwitchListTile(
                title: const Text('Notifications'),
                value: controller.notificationsEnabled.value,
                onChanged: controller.toggleNotifications,
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: controller.darkModeEnabled.value,
                onChanged: controller.toggleDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }
}

