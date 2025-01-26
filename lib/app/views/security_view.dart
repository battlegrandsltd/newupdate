import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/lock_controller.dart';
import 'package:playground/app/modules/Settings/controllers/settings_controller.dart';

import '../resources/color_manager.dart';
import '../routes/app_pages.dart';

class SecurityView extends GetView {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find();
    LockController lockController = Get.find();
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            controller.selectedPage.value = 0;
          },
        ),
        title: const Text(
          'Security',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage settings that keep your account secure',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorManager.background2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SecurityMenuItem(
                    title: 'Forgot Password',
                    onTap: () {
                      Get.toNamed(Routes.FORGET_PASSWORD);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Enable Biometric Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Obx(() => Switch(
                          value: lockController.isBiometricEnabled.value,
                          onChanged: lockController.toggleBiometric,
                          activeColor: ColorManager.primary,
                          inactiveThumbColor: ColorManager.secondary,
                          inactiveTrackColor: ColorManager.lightGrey1,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecurityMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SecurityMenuItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(color: Colors.grey[300]),
      ],
    );
  }
}
