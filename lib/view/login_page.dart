
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/button.dart';
import '../widgets/customTextFormField.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      'Welcome Admin',
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 24.w),
                    CustomTextFormField(
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;
                      },
                      color: Colors.white,
                      width: double.infinity,
                      hintText: 'Email...',
                      controller: emailC,
                      border: const OutlineInputBorder(),
                    ),
                    CustomTextFormField(
                      hintText: 'Password...',
                      controller: passwordC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "password can not be empty";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Obx(() => _loginController.obsText.value == false
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                        onPressed: _loginController.toggleObsText,
                      ),
                      obscureText: _loginController.obsText.value,
                      width: double.infinity,
                      border: const OutlineInputBorder(),
                    ),
                    Button(
                      color: Colors.redAccent,
                      isLoading: _loginController.formStateLoading.value,
                      buttonText: 'Log In',
                      height: 14.w,
                      width: 180.w,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _loginController.submit(emailC.text, passwordC.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
