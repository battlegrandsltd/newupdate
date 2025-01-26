import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';

class EditProfileController extends GetxController {
  UserController userController = Get.find<UserController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  var photo = "0".obs;

  void updateProfile() async {
    userController.name.value = nameController.text;
    userController.title.value = titleController.text;
    userController.location.value = locationController.text;
    userController.photo.value = photo.value;
    await userController.updateProfile();
    Get.back();
  }

  @override
  void onInit() {
    nameController.text = userController.name.value;
    titleController.text = userController.title.value;
    locationController.text = userController.location.value;
    photo.value = userController.photo.value;
    super.onInit();
  }
}
