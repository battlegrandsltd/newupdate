import 'package:get/get.dart';

import '../controllers/match_detail_controller.dart';

class MatchDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchDetailController>(
      () => MatchDetailController(),
    );
  }
}
