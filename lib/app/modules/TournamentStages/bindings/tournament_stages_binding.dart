import 'package:get/get.dart';

import '../controllers/tournament_stages_controller.dart';

class TournamentStagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TournamentStagesController>(
      () => TournamentStagesController(),
    );
  }
}
