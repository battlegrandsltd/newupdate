import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';

import '../../../controllers/authentication_controller.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  Rx<int> selectedPage = 0.obs;

  Future<void> signOut() async {
    await Get.find<AuthenticationController>().signOut();
    await Get.find<UserController>().signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
