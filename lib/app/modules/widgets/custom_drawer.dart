import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/Main/controllers/main_controller.dart';
import 'package:playground/app/resources/assets_manager.dart';
import '../../controllers/user_controller.dart';
import '../../resources/color_manager.dart';
import 'drawer_menu_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    UserController userController = Get.find<UserController>();
    return SizedBox(
      width: Get.width * .8,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 35, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    mainController.closeDrawer(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.primary.withOpacity(.4),
                          width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close,
                        color: ColorManager.primary, size: 32),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * .15),
          SizedBox(
            width: Get.width * .8,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                mainController.selectedIndex = 2;
                mainController.closeDrawer(context);
              },
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManager.primary,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/user avatar (${userController.photo.value}).png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.name.value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * .5,
                          child: Row(
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '${userController.xp.value} XP',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Divider(
                  color: ColorManager.lightGrey,
                  thickness: 1,
                ),
                const DrawerMenuItem(
                  title: 'Settings',
                  icon: AssetsManager.settings,
                  pageUrl: '/settings',
                ),
                Obx(() => DrawerMenuItem(
                      title: 'Wallet',
                      icon: AssetsManager.wallet,
                      pageUrl: '/wallet',
                      trailing: Text(
                        'GHS ${userController.coins.value.toString()}',
                        style: const TextStyle(
                          color: ColorManager.lightGrey2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )),
                const DrawerMenuItem(
                  title: 'Message',
                  icon: AssetsManager.messages,
                  pageUrl: '/messages',
                  // trailing: Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: ColorManager.lightPrimary,
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: const Text(
                  //     '54',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
