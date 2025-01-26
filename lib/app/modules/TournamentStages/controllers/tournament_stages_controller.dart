import 'package:get/get.dart';
import 'package:playground/app/data/models/game.dart';
import 'package:playground/app/data/models/tournament.dart';

import '../../../controllers/games_controller.dart';
import '../../../controllers/round_controller.dart';
import '../../../data/models/round.dart';

class TournamentStagesController extends GetxController {
  Tournament tournament = Get.arguments;
  RoundController roundController = Get.find<RoundController>();
  GamesController gamesController = Get.find<GamesController>();
  List<Round> rounds = <Round>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRounds();
  }

  void getRounds() {
    rounds = roundController.rounds
        .where((round) => round.tournamentId == tournament.id)
        .toList();
  }

  List<Game> getGames(String roundID) {
    return gamesController.games
        .where((game) =>
            game.tournamentId == tournament.id && game.roundId == roundID)
        .toList();
  }
}
