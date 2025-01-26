import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LocalDatabaseController extends GetxController {
  final String key = "3141863047300867";
  late EncryptedSharedPreferences sharedPref;

  Future<void> initialize() async {
    try {
      await EncryptedSharedPreferences.initialize(key);
      sharedPref = EncryptedSharedPreferences.getInstance();
    } catch (e) {
      debugPrint('Error initializing shared preferences: $e');
    }
  }

  Future<bool> clear() async {
    return sharedPref.clear();
  }

  void setBiometric(bool auth) {
    sharedPref.setBoolean('biometric', auth);
  }

  bool getBiometric() {
    return sharedPref.getBoolean('biometric') ?? false;
  }
}
