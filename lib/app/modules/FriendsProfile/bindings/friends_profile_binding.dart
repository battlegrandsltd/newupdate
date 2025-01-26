import 'package:get/get.dart';

import '../controllers/friends_profile_controller.dart';

class FriendsProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendsProfileController>(
      () => FriendsProfileController(),
    );
  }
}
