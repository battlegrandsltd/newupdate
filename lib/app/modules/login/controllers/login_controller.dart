import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import '../../../controllers/authentication_controller.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();
  final UserController userController = Get.find<UserController>();
  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    bool result = await _authenticationController.logInWithEmail(
      emailController.text,
      passwordController.text,
    );
    if (result) {
      await userController.loginUser(_authenticationController.user!.uid);
      Get.snackbar(
        'Success',
        'Login successful',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAndToNamed(Routes.MAIN);
    }
  }
}
