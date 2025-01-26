import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:playground/app/modules/home/views/home_view.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:playground/app/resources/color_manager.dart';

import '../../widgets/custom_drawer.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.canPop,
      onPopInvokedWithResult: (pop, r) {
        if (controller.lastPressedAt == null ||
            DateTime.now().difference(controller.lastPressedAt!) >
                const Duration(seconds: 2)) {
          controller.lastPressedAt = DateTime.now();
          Get.snackbar(
            'Exit App?',
            'Press back again to exit',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
          controller.canPop = false;
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary50,
        body: Stack(children: [
          const CustomDrawer(),
          const HomeView(),
          if (!controller.isDeviceConnected.value)
            Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ]),
        extendBody: true,
        bottomNavigationBar: GetBuilder<MainController>(
          init: MainController(),
          id: 'main',
          builder: (_) {
            return AnimatedContainer(
              transform: Matrix4.translationValues(
                  controller.yOffset, controller.yOffset, 0.0)
                ..scale(controller.scaleFactor),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: ColorManager.background1,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: ColorManager.background1,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  backgroundColor: ColorManager.background1,
                  selectedItemColor: ColorManager.primary,
                  unselectedItemColor: ColorManager.lightGrey2,
                  currentIndex: controller.selectedIndex,
                  onTap: controller.changeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        controller.selectedIndex == 0
                            ? AssetsManager.home_filled
                            : AssetsManager.home,
                        colorFilter: ColorFilter.mode(
                            controller.selectedIndex == 0
                                ? ColorManager.primary
                                : ColorManager.lightGrey2,
                            BlendMode.srcIn),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        controller.selectedIndex == 1
                            ? AssetsManager.tournament_filled
                            : AssetsManager.tournament,
                        colorFilter: ColorFilter.mode(
                            controller.selectedIndex == 1
                                ? ColorManager.primary
                                : ColorManager.lightGrey2,
                            BlendMode.srcIn),
                      ),
                      label: 'Tournament',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        controller.selectedIndex == 2
                            ? AssetsManager.profile_filled
                            : AssetsManager.profile,
                        colorFilter: ColorFilter.mode(
                            controller.selectedIndex == 2
                                ? ColorManager.primary
                                : ColorManager.lightGrey2,
                            BlendMode.srcIn),
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
