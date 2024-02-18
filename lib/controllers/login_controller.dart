import 'package:get/get.dart';

class LoginController extends GetxController {
  var obsText = true.obs;
  var formStateLoading = false.obs;
  var email = 'admin@gmail.com';
  var password = 'admin123';

  void toggleObsText() {
    obsText.toggle();
  }

  Future<void> submit(String email, String password) async {
    // Simulate network request
    formStateLoading.toggle();

    // Simulate authentication process
    await Future.delayed(const Duration(seconds: 2));

    if (email == this.email && password == this.password) {
      // Navigate to home screen
      Get.offAllNamed('/home');
    } else {
      // Show error dialogue
      Get.defaultDialog(title: 'Error', middleText: 'Invalid email or password');
    }

    formStateLoading.toggle();
  }
}
