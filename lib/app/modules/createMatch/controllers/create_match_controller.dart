import 'package:get/get.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:uuid/uuid.dart';

class CreateMatchController extends GetxController {
  var filled = false.obs;
  GamesController gamesController = Get.find();
  UserController userController = Get.find();

  Future<bool> addGame(String game, String platform, String about, String rules,
      String amount, String image) async {
    if (double.parse(amount) > userController.coins.value) {
      return false;
    }
    var uuid = const Uuid();
    String id = uuid.v1();
    await gamesController.addGame(id, game, platform, about, rules,
        double.parse(amount), userController.uid.value, image);
    userController.addGameCreated(id);
    userController.addGamePlayed(id);
    userController.addCoins(-double.parse(amount));
    return true;
  }
}
