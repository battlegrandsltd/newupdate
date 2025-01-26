import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playground/app/controllers/database_controller.dart';
import 'package:playground/app/data/models/game.dart';

class GamesController extends GetxController {
  List<Game> games = <Game>[].obs;
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getGames();
  }

  void getGames() async {
    dynamic result = await _databaseController.getData('games');
    if (result != null) {
      games = result.values
          .map<Game>((gameMap) {
            return Game.fromMap(gameMap);
          })
          .where((game) => game != null)
          .toList();
    }
  }

  Future<Game> getGame(String id) async {
    dynamic result = await _databaseController.getData('games/$id');
    return Game.fromMap(result);
  }

  Stream<List<Game>> getOpenGames(String id) {
    return _databaseController.getStream('games').map((event) {
      List<Game> games = event.snapshot.value.values
          .map<Game>((gameMap) {
            return Game.fromMap(gameMap);
          })
          .where((game) => game != null)
          .toList();
      return games
          .where((game) =>
              game.status == "open" &&
              game.tournamentId == "" &&
              game.roundId == "")
          .toList();
    });
  }

  Game? findGame(String id) {
    return games.firstWhere((game) => game.id == id);
  }

  Future<void> addGame(String id, String game, String platform, String about,
      String rules, double amount, String creator, String image) async {
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    Game newGame = Game(
      id: id,
      name: game,
      platform: platform,
      description: about,
      rules: rules,
      amount: amount,
      image: image,
      creator: creator,
      date: format.format(DateTime.now()),
      player_1: creator,
      player_2: '',
      time: "02:00:00",
    );
    games.add(newGame);
    await _databaseController.setData('games/${newGame.id}', newGame.toMap());
  }

  Future<void> joinGame(String id, String player) async {
    Game game = await getGame(id);
    if (game.player_2.isNotEmpty || game.status.toLowerCase() != 'open') {
      return;
    }
    game.player_2 = player;
    game.status = 'started';
    await _databaseController.setData('games/$id', game.toMap());
  }

  Future<void> updateGame(String id, String player, String link, String result,
      bool isPlayer_1) async {
    Game game = findGame(id)!;
    game.status = 'under review';
    if (isPlayer_1) {
      game.link_1 = link;
      game.result_1 = result;
    } else {
      game.link_2 = link;
      game.result_2 = result;
    }
    await _databaseController.setData('games/$id', game.toMap());
  }
}
