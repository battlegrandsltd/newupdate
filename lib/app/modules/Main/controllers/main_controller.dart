import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MainController extends GetxController {
  late double xOffset, yOffset, scaleFactor;
  bool isDrawerOpen = false;
  late StreamSubscription subscription;
  var isDeviceConnected = true.obs;
  bool canPop = false;
  DateTime? lastPressedAt;
  int selectedIndex = 0;

  @override
  void onInit() {
    checkConnectivity();
    xOffset = yOffset = 0.0;
    scaleFactor = 1.0;
    isDrawerOpen = false;
    super.onInit();
  }

  Future<void> checkConnectivity() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected.value = await InternetConnectionChecker().hasConnection;
    });
  }

  void closeDrawer(context) {
    xOffset = 0.0;
    yOffset = 0.0;
    scaleFactor = 1;
    isDrawerOpen = false;
    update(['main']);
  }

  void openDrawer(context) {
    xOffset = Get.width * 0.80;
    yOffset = Get.height * 0.1;
    scaleFactor = 0.8;
    isDrawerOpen = true;
    update(['main']);
  }

  void changeIndex(int index) {
    selectedIndex = index;
    update(['main']);
  }
}
