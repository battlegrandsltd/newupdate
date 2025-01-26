import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';
import 'package:playground/app/data/models/top_game.dart';

class TopGamesController extends GetxController {
  List<TopGame> topGames = <TopGame>[].obs;
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getTopGames();
  }

  Future<void> getTopGames() async {
    dynamic result = await _databaseController.getData('top_games');
    if (result != null) {
      topGames = result.values
          .map<TopGame>((gameMap) {
            return TopGame.fromMap(gameMap);
          })
          .where((game) => game != null)
          .toList();
    }
  }
}
