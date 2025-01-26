import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';

class UserController extends GetxController {
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  RxString uid = ''.obs;
  RxString name = ''.obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString photo = '1'.obs;
  RxString title = 'Newbie'.obs;
  RxString location = 'Ghana'.obs;
  RxInt xp = 0.obs;
  RxInt level = 1.obs;
  RxInt coins = 0.obs;
  RxString gender = "Male".obs;
  RxString dob = 'not set'.obs;
  RxString fcmToken = ''.obs;
  var medals = <String>[].obs;
  var gamesCreated = <String>[].obs;
  var gamesPlayed = <String>[].obs;
  var gamesWon = <String>[].obs;
  var gamesBookmarked = <String>[].obs;
  var interests = <String>[].obs;
  var tournamentsPlayed = <String>[].obs;
  var tournamentsWon = <String>[].obs;
  var tournamentsBookmarked = <String>[].obs;
  var chats = <String>[].obs;

  void createUser(
      String uid, String name, String phone, String email, String password) {
    this.uid.value = uid;
    this.name.value = name;
    this.phone.value = phone;
    this.email.value = email;
    this.password.value = password;
    _databaseController.setData('users/$uid', toMap());
  }

  Future<void> loginUser(String uid) async {
    this.uid.value = uid;
    dynamic data = await _databaseController.getData('users/$uid');
    fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid.value,
      'name': name.value,
      'phone': phone.value,
      'email': email.value,
      'password': password.value,
      'photo': photo.value,
      'title': title.value,
      'location': location.value,
      'xp': xp.value,
      'level': level.value,
      'coins': coins.value,
      'gender': gender.value,
      'dob': dob.value,
      'medals': medals,
      'gamesPlayed': gamesPlayed,
      'gamesCreated': gamesCreated,
      'gamesWon': gamesWon,
      'gamesBookmarked': gamesBookmarked,
      'interests': interests,
      'tournamentsPlayed': tournamentsPlayed,
      'tournamentsWon': tournamentsWon,
      'tournamentsBookmarked': tournamentsBookmarked,
      'fcmToken': fcmToken.value,
      'chats': chats
    };
  }

  void fromMap(dynamic map) {
    name.value = map['name'] ?? '';
    phone.value = map['phone'] ?? '';
    email.value = map['email'] ?? '';
    password.value = map['password'] ?? '';
    photo.value = map['photo'] ?? '1';
    title.value = map['title'] ?? 'Newbie';
    location.value = map['location'] ?? 'Ghana';
    xp.value = map['xp'] ?? 0;
    level.value = map['level'] ?? 1;
    coins.value = map['coins'] ?? 0;
    gender.value = map['gender'] ?? 'Male';
    dob.value = map['dob'] ?? 'not set';
    fcmToken.value = map['fcmToken'] ?? '';
    medals.value = map['medals'] == null
        ? []
        : List<String>.from(map['medals'] ?? <String>[]);
    gamesPlayed.value = map['gamesPlayed'] == null
        ? []
        : List<String>.from(map['gamesPlayed'] ?? <String>[]);
    gamesCreated.value = map['gamesCreated'] == null
        ? []
        : List<String>.from(map['gamesCreated'] ?? <String>[]);
    gamesWon.value = map['gamesWon'] == null
        ? []
        : List<String>.from(map['gamesWon'] ?? <String>[]);
    gamesBookmarked.value =
        List<String>.from(map['gamesBookmarked'] ?? <String>[]);
    interests.value = map['interests'] == null
        ? []
        : List<String>.from(map['interests'] ?? <String>[]);
    tournamentsPlayed.value = map['tournamentsPlayed'] == null
        ? []
        : List<String>.from(map['tournamentsPlayed'] ?? <String>[]);
    tournamentsWon.value = map['tournamentsWon'] == null
        ? []
        : List<String>.from(map['tournamentsWon'] ?? <String>[]);
    tournamentsBookmarked.value = map['tournamentsBookmarked'] == null
        ? []
        : List<String>.from(map['tournamentsBookmarked'] ?? <String>[]);
    chats.value = map['chats'] == null
        ? []
        : List<String>.from(map['chats'] ?? <String>[]);
  }

  dynamic findUser(String uid) async {
    return await _databaseController.getData('users/$uid');
  }

  Future<void> updateProfile() async {
    print('updating profile: ${toMap()}');
    await _databaseController.updateData('users/$uid', toMap());
  }

  void addInterest(String interest) {
    if (!interests.contains(interest)) {
      interests.add(interest);
      updateProfile();
    }
  }

  void removeInterest(String interest) {
    interests.remove(interest);
    updateProfile();
  }

  void addMedal(String medal) {
    if (!medals.contains(medal)) {
      medals.add(medal);
      updateProfile();
    }
  }

  void addGamePlayed(String gameId) {
    if (!gamesPlayed.contains(gameId)) {
      gamesPlayed.add(gameId);
      updateProfile();
    }
  }

  void addGameCreated(String gameId) {
    if (!gamesCreated.contains(gameId)) {
      gamesCreated.add(gameId);
      updateProfile();
    }
  }

  void addGameWon(String gameId) {
    if (!gamesWon.contains(gameId)) {
      gamesWon.add(gameId);
      updateProfile();
    }
  }

  void addTournamentPlayed(String tournamentId) {
    if (!tournamentsPlayed.contains(tournamentId)) {
      tournamentsPlayed.add(tournamentId);
      updateProfile();
    }
  }

  void addTournamentWon(String tournamentId) {
    if (!tournamentsWon.contains(tournamentId)) {
      tournamentsWon.add(tournamentId);
      updateProfile();
    }
  }

  void addGameBookmarked(String gameId) {
    if (!gamesBookmarked.contains(gameId)) {
      gamesBookmarked.add(gameId);
      updateProfile();
    }
  }

  void removeGameBookmarked(String gameId) {
    gamesBookmarked.remove(gameId);
    updateProfile();
  }

  void addTournamentBookmarked(String tournamentId) {
    if (!tournamentsBookmarked.contains(tournamentId)) {
      tournamentsBookmarked.add(tournamentId);
      updateProfile();
    }
  }

  void removeTournamentBookmarked(String tournamentId) {
    tournamentsBookmarked.remove(tournamentId);
    updateProfile();
  }

  void addChat(String chatId) {
    if (!chats.contains(chatId)) {
      chats.add(chatId);
      updateProfile();
    }
  }

  void addCoins(double amount) {
    coins.value += amount.toInt();
    updateProfile();
  }

  void setFCMToken(String token) {
    fcmToken.value = token;
    // updateProfile();
  }

  Future<void> signOut() async {
    uid.value = '';
    name.value = '';
    phone.value = '';
    email.value = '';
    password.value = '';
    photo.value = '1';
    title.value = 'Newbie';
    location.value = 'Ghana';
    dob.value = '';
    gender.value = 'Male';
    xp.value = 0;
    level.value = 1;
    coins.value = 0;
    fcmToken.value = '';
    medals.clear();
    gamesPlayed.clear();
    gamesCreated.clear();
    gamesWon.clear();
    gamesBookmarked.clear();
    interests.clear();
    tournamentsPlayed.clear();
    tournamentsWon.clear();
    tournamentsBookmarked.clear();
    chats.clear();
  }
}
