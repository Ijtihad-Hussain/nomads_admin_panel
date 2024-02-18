
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var notificationsEnabled = true.obs;
  var darkModeEnabled = false.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    _applyDarkMode();
  }

  void _applyDarkMode() {
    if (darkModeEnabled.value) {
      // Apply dark mode styles or settings here
    } else {
      // Remove dark mode styles or settings here
    }
  }
}
