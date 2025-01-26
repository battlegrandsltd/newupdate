import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/resources/color_manager.dart';

void showLoading() {
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideLoading() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}
