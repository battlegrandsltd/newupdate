import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'local_database_controller.dart';

class LockController extends GetxController {
  var isBiometricEnabled = false.obs;
  final LocalDatabaseController databaseController =
      Get.find<LocalDatabaseController>();
  @override
  void onInit() {
    super.onInit();
    isBiometricEnabled.value = databaseController.getBiometric();
  }

  void toggleBiometric(bool value) {
    isBiometricEnabled.value = value;
    databaseController.setBiometric(value);
  }

  Future<bool> authenticate() async {
    try {
      var auth = LocalAuthentication();
      bool authenticated = await auth.authenticate(
          localizedReason: 'Biometric authentication is enabled',
          options: const AuthenticationOptions(
              useErrorDialogs: false, stickyAuth: false, biometricOnly: false));
      if (authenticated) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error authenticating user: $e');
      return false;
    }
  }
}
