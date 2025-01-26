import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';

import '../data/models/round.dart';

class RoundController extends GetxController {
  List<Round> rounds = <Round>[].obs;
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getRounds();
  }

  void getRounds() async {
    dynamic result = await _databaseController.getData('rounds');
    if (result != null) {
      rounds = result.values
          .map<Round>((roundMap) {
            return Round.fromMap(roundMap);
          })
          .where((round) => round != null)
          .toList();
    }
  }

  Future<Round> getRound(String id) async {
    dynamic result = await _databaseController.getData('rounds/$id');
    return Round.fromMap(result);
  }

  Stream<List<Round>> getOpenRounds(String id) {
    return _databaseController.getStream('rounds').map((event) {
      List<Round> rounds = event.snapshot.value.values
          .map<Round>((roundMap) {
            return Round.fromMap(roundMap);
          })
          .where((round) => round != null)
          .toList();
      return rounds.where((round) => round.status == "open").toList();
    });
  }

  Round? findRound(String id) {
    return rounds.firstWhere((round) => round.id == id);
  }

  Future<void> joinRound(String id, String player) async {
    Round round = await getRound(id);
    if (round.status.toLowerCase() != 'open' ||
        round.players.contains(player)) {
      return;
    }
    round.players.add(player);
    await _databaseController.setData('rounds/$id', round.toMap());
  }
}
