import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/Settings/controllers/settings_controller.dart';
import 'package:playground/app/modules/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/color_manager.dart';

class AccountView extends GetView {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find();
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
          'Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     blurRadius: 5,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
            ),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountMenuItem(
                  title: 'Personal Information',
                  subtitle: 'Edit your personal account information',
                  onTap: () {
                    controller.selectedPage.value = 6;
                  },
                ),
                AccountMenuItem(
                  title: 'Delete Account',
                  subtitle: 'Permanently close your account',
                  onTap: () {
                    customDialog(
                      'Delete Account',
                      'Are you sure you want to delete your account?',
                      'Delete',
                      'Cancel',
                      () {
                        launchUrl(Uri.parse('https://www.google.com'));
                        Get.back();
                      },
                      () {
                        Get.back();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AccountMenuItem({
    super.key,
    required this.title,
    required this.subtitle,
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
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(color: ColorManager.lightGrey),
      ],
    );
  }
}
