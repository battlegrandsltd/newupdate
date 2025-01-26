import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/authentication_controller.dart';
import '../../../routes/app_pages.dart';

class ForgetPasswordController extends GetxController {
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();
  TextEditingController emailController = TextEditingController();

  void sendResetEmail() async {
    bool result =
        await _authenticationController.resetPassword(emailController.text);
    if (result) {
      Get.snackbar(
        'Success',
        'Account created successfully. Please login to continue.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
