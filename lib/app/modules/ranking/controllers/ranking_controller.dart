import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';
import 'package:playground/app/data/models/profile.dart';

class RankingController extends GetxController {
  final DatabaseController _databaseController = Get.find<DatabaseController>();
  RxList<Profile> profiles = <Profile>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProfiles();
  }

  Future<void> getProfiles() async {
    dynamic result = await _databaseController.getData('users');
    if (result != null) {
      profiles.value = result.values
          .map<Profile>((profileMap) {
            return Profile.fromMap(profileMap);
          })
          .where((profile) => profile != null)
          .toList();
    }
    profiles.sort((a, b) => b.gamesWon.length.compareTo(a.gamesWon.length));
  }
}
