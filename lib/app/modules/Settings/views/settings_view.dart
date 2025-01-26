import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/views/account_view.dart';
import 'package:playground/app/views/personal_information_view.dart';
import 'package:playground/app/views/security_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/color_manager.dart';
import '../../widgets/custom_search_field.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.selectedPage.value == 0
        ? const Settings()
        : controller.selectedPage.value == 1
            ? const AccountView()
            : controller.selectedPage.value == 2
                ? const SecurityView()
                : controller.selectedPage.value == 6
                    ? const PersonalInformationView()
                    : const SizedBox());
  }
}

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find();
    RxString search = ''.obs;
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: Get.width - 32,
          height: Get.height - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchField(
                search: search,
              ),
              const SizedBox(height: 20),
              const Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
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
                child: Obx(() {
                  final filteredItems = <SettingsMenuItem>[
                    SettingsMenuItem(
                      title: 'Account',
                      icon: Icons.account_circle,
                      iconColor: Colors.blue,
                      onTap: () {
                        controller.selectedPage.value = 1;
                      },
                      pages: const [
                        'Account',
                        'Personal Information',
                        'Delete Account'
                      ],
                    ),
                    SettingsMenuItem(
                      title: 'Security',
                      icon: Icons.security,
                      iconColor: Colors.green,
                      onTap: () {
                        controller.selectedPage.value = 2;
                      },
                      pages: const [
                        'Security',
                        'Change Password',
                        'Two-Factor Authentication'
                      ],
                    ),
                    SettingsMenuItem(
                      title: 'Privacy',
                      icon: Icons.lock,
                      iconColor: Colors.purple,
                      onTap: () {
                        launchUrl(Uri.parse('https://www.google.com'));
                      },
                      pages: const [
                        'Privacy Policy',
                        'Terms of Service',
                        'Cookie Policy'
                      ],
                    ),
                    SettingsMenuItem(
                      title: 'Help & FAQ',
                      icon: Icons.help,
                      iconColor: Colors.pink,
                      onTap: () {
                        launchUrl(Uri.parse('https://www.google.com'));
                      },
                      pages: const ['Help', 'FAQ', 'Contact Us'],
                    ),
                    SettingsMenuItem(
                      title: 'About Battlegrands',
                      icon: Icons.info,
                      iconColor: Colors.blue,
                      onTap: () {
                        launchUrl(Uri.parse('https://www.google.com'));
                      },
                      pages: const ['About Us', 'Careers'],
                    ),
                    SettingsMenuItem(
                      title: 'Sign Out',
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      onTap: () async {
                        await controller.signOut();
                      },
                      pages: const ['Sign Out'],
                    ),
                  ]
                      .where((element) => element.pages.any((page) => page
                          .toLowerCase()
                          .contains(search.value.toLowerCase())))
                      .toList();

                  return Column(
                    children: filteredItems.isEmpty
                        ? [
                            const Center(
                              child: Text(
                                'No matching results',
                                style: TextStyle(color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]
                        : [
                            if (search.value.isNotEmpty)
                              const Text('Found results in following page(s)'),
                            ...filteredItems.map((item) => item),
                          ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final List<String> pages;

  const SettingsMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.pages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
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
