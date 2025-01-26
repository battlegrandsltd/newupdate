import 'package:get/get.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/controllers/tournament_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/tournament.dart';

import '../../../data/models/game.dart';

class TournamentDetailController extends GetxController {
  RxBool isJoined = false.obs;
  Rx<Tournament> tournament = (Get.arguments as Tournament).obs;
  UserController userController = Get.find<UserController>();
  GamesController gamesController = Get.find<GamesController>();
  TournamentController tournamentController = Get.find<TournamentController>();
  List<Game> games = <Game>[].obs;
  RxBool canBuy = true.obs;
  RxBool isAvailable = true.obs;

  Future<bool> fetchTournament() async {
    tournament.value =
        await tournamentController.getTournament(tournament.value.id);
    canBuy.value = tournament.value.amount <= userController.coins.value;

    isJoined.value =
        tournament.value.players.contains(userController.uid.value);
    isAvailable.value = tournament.value.status == 'open';
    getGames();
    return true;
  }

  void getGames() {
    games = gamesController.games
        .where((game) => game.tournamentId == tournament.value.id)
        .toList();
  }

  void joinTournament() async {
    await fetchTournament();
    if (isJoined.value || !canBuy.value || !isAvailable.value) {
      return;
    }
    await tournamentController.joinTournament(
        tournament.value.id, userController.uid.value);
    userController.addTournamentPlayed(tournament.value.id);
    userController.addCoins(-tournament.value.amount);
    isJoined.value = true;
  }
}
