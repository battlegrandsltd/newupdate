import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/Main/controllers/main_controller.dart';
import 'package:playground/app/views/discover_view.dart';
import 'package:playground/app/views/profile_view.dart';
import 'package:playground/app/views/tournament.dart';
import 'package:playground/app/views/tournament_view.dart';

import '../../../resources/color_manager.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return GetBuilder<MainController>(
      init: MainController(),
      id: 'main',
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () async {
            // controller.reloadData();
          },
          color: ColorManager.primary,
          backgroundColor: ColorManager.white,
          child: AnimatedContainer(
              transform: Matrix4.translationValues(
                  mainController.xOffset, mainController.yOffset, 0.0)
                ..scale(mainController.scaleFactor),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: (mainController.isDrawerOpen)
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
                color: ColorManager.background1,
              ),
              child: mainController.isDrawerOpen
                  ? InkWell(
                      onTap: () {
                        mainController.closeDrawer(context);
                      },
                      child: Container())
                  : mainController.selectedIndex == 0
                      ? const DiscoverView()
                      : mainController.selectedIndex == 1
                          ? AdminTournament()
                          //  const TournamentView()
                          : const ProfileView()),
        );
      },
    );
  }
}
