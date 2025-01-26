import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';

import '../data/models/tournament.dart';

class TournamentController extends GetxController {
  List<Tournament> tournaments = <Tournament>[].obs;
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getTournaments();
  }

  void getTournaments() async {
    dynamic result = await _databaseController.getData('tournaments');
    if (result != null) {
      tournaments = result.values
          .map<Tournament>((tournamentMap) {
            return Tournament.fromMap(tournamentMap);
          })
          .where((tournament) => tournament != null)
          .toList();
    }
  }

  Future<Tournament> getTournament(String id) async {
    dynamic result = await _databaseController.getData('tournaments/$id');
    return Tournament.fromMap(result);
  }

  Stream<List<Tournament>> getOpenTournaments(String id) {
    return _databaseController.getStream('tournaments').map((event) {
      List<Tournament> tournaments = event.snapshot.value.values
          .map<Tournament>((tournamentMap) {
            return Tournament.fromMap(tournamentMap);
          })
          .where((tournament) => tournament != null)
          .toList();
      return tournaments
          .where((tournament) => tournament.status == "open")
          .toList();
    });
  }

  Tournament? findTournament(String id) {
    return tournaments.firstWhere((tournament) => tournament.id == id);
  }

  Future<void> joinTournament(String id, String player) async {
    Tournament tournament = await getTournament(id);
    if (tournament.status.toLowerCase() != 'open' ||
        tournament.players.contains(player)) {
      return;
    }
    tournament.players.add(player);
    await _databaseController.setData('tournaments/$id', tournament.toMap());
  }

  // Future<void> updateTournament(String id, String player, String link, String result,
  //     bool isCreator) async {
  //   Tournament tournament = findTournament(id)!;
  //   tournament.status = 'under review';
  //   if (isCreator) {
  //     tournament.link_1 = link;
  //     tournament.result_1 = result;
  //   } else {
  //     tournament.link_2 = link;
  //     tournament.result_2 = result;
  //   }
  //   await _databaseController.saveData('tournaments/$id', tournament.toMap());
  // }
}
