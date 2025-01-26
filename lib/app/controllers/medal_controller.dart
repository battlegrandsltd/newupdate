import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';
import 'package:playground/app/data/models/medal.dart';

class MedalController extends GetxController {
  List<Medal> medals = [];
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getMedals();
  }

  void getMedals() async {
    dynamic result = await _databaseController.getData('medals');
    if (result != null) {
      medals = result.values
          .map<Medal>((medalMap) {
            return Medal.fromMap(medalMap);
          })
          .where((medal) => medal != null)
          .toList();
    }
  }

  Medal findMedal(String id) {
    return medals.firstWhere((medal) => medal.id == id);
  }
}
