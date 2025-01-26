import 'package:get/get.dart';

import '../../Messages/controllers/messages_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagesController>(
      () => MessagesController(),
    );
  }
}
