import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../../../controllers/authentication_controller.dart';

class SignInController extends GetxController {
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();
  final UserController userController = Get.find<UserController>();

  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void signUp() async {
    bool result = await _authenticationController.signUpWithEmail(
      emailController.text,
      passwordController.text,
    );
    if (result) {
      userController.createUser(
        _authenticationController.user!.uid,
        usernameController.text,
        phoneController.text,
        emailController.text,
        passwordController.text,
      );
      Get.snackbar(
        'Success',
        'Account created successfully. Please login to continue.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAndToNamed(Routes.MAIN);
    }
  }
}
