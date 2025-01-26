import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/widgets/custom_button.dart';

import '../../resources/color_manager.dart';

Future<void> customDialog(
  String title,
  String content,
  String button1,
  String? button2,
  void Function()? action1,
  void Function()? action2,
) async {
  return await Get.dialog(
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: ColorManager.lightGrey2,
        ),
      ),
      actions: [
        if (button2 != null) CustomButton(title: button2, onPressed: action2),
        CustomButton(
            title: button1,
            onPressed: action1,
            backgroundColor: ColorManager.primary,
            foregroundColor: Colors.white),
      ],
    ),
  );
}
