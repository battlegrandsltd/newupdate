import 'package:playground/app/controllers/database_controller.dart';

class Profile {
  String uid;
  String name;
  String photo;
  String title;
  String location;
  int xp;
  int level;
  int coins;
  String fcmToken;

  List<String> medals;
  List<String> gamesPlayed;
  List<String> gamesCreated;
  List<String> gamesWon;
  List<String> chats;

  Profile({
    required this.uid,
    required this.name,
    required this.photo,
    required this.title,
    required this.location,
    required this.fcmToken,
    required this.xp,
    required this.level,
    required this.coins,
    required this.medals,
    required this.gamesPlayed,
    required this.gamesCreated,
    required this.gamesWon,
    required this.chats,
  });

  static Profile fromMap(dynamic map) {
    return Profile(
      uid: map['uid'],
      name: map['name'],
      photo: map['photo'] ?? '1',
      title: map['title'],
      location: map['location'] ?? 'Ghana',
      fcmToken: map['fcmToken'] ?? '',
      xp: map['xp'] ?? 0,
      level: map['level'] ?? 1,
      coins: map['coins'] ?? 0,
      medals: map['medals'] == null
          ? []
          : (List<String>.from(map['medals'].map((item) => item.toString()))),
      gamesPlayed: map['gamesPlayed'] == null
          ? []
          : (List<String>.from(
              map['gamesPlayed'].map((item) => item.toString()))),
      gamesCreated: map['gamesCreated'] == null
          ? []
          : (List<String>.from(
              map['gamesCreated'].map((item) => item.toString()))),
      gamesWon: map['gamesWon'] == null
          ? []
          : (List<String>.from(map['gamesWon'].map((item) => item.toString()))),
      chats: map['chats'] == null
          ? []
          : (List<String>.from(map['chats'].map((item) => item.toString()))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photo': photo,
      'title': title,
      'location': location,
      'fcmToken': fcmToken,
      'xp': xp,
      'level': level,
      'coins': coins,
      'medals': medals,
      'gamesPlayed': gamesPlayed,
      'gamesCreated': gamesCreated,
      'gamesWon': gamesWon,
      'chats': chats,
    };
  }

  static Future<Profile> findUser(String id) async {
    DatabaseController databaseController = DatabaseController();
    return fromMap(await databaseController.getData('users/$id'));
  }

  static Future<List<Profile>> findPlayers(String id_1, String id_2) async {
    print('id1 $id_1 id2 $id_2');
    if (id_1 == "" && id_2 == "") {
      return [];
    }
    DatabaseController databaseController = DatabaseController();
    var player_1 = fromMap(await databaseController.getData('users/$id_1'));
    if (id_2 == "") {
      return [player_1];
    }
    var player_2 = fromMap(await databaseController.getData('users/$id_2'));
    return [player_1, player_2];
  }

  static Future<void> addChatToUser(String user, String chatId) async {
    DatabaseController databaseController = DatabaseController();
    var profile = fromMap(await databaseController.getData('users/$user'));
    profile.chats.add(chatId);
    await databaseController.updateData('users/$user', profile.toMap());
  }
}
