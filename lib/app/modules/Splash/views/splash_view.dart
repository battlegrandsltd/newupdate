import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:playground/app/resources/color_manager.dart';

import '../../../controllers/notification_controller.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    NotificationController notificationController = Get.find();
    notificationController.init(context);
    return Scaffold(
        backgroundColor: ColorManager.background1,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.logo,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorManager.primary),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  AssetsManager.branding,
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ));
  }
}
