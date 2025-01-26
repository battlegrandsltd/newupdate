import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/lock_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';

import '../../../controllers/authentication_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final _authenticationController = Get.find<AuthenticationController>();
  final userController = Get.find<UserController>();
  final _lockController = Get.find<LockController>();
  @override
  void onReady() async {
    super.onReady();
    if (_authenticationController.user != null) {
      await userController.loginUser(_authenticationController.user!.uid);
      bool locked = false;
      if (_lockController.isBiometricEnabled.value == true) {
        locked = await _lockController.authenticate();
      } else {
        locked = true;
      }
      if (locked) {
        Get.offAndToNamed(Routes.MAIN);
      } else {
        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Authentication failed'),
            content: const Text('Please try again'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                  onReady();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
