import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/chat.dart';
import 'package:playground/app/data/models/game.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../../../controllers/chat_controller.dart';
import '../../../data/models/profile.dart';
import '../../widgets/custom_dialog.dart';

class MatchDetailController extends GetxController {
  RxBool isCreator = false.obs;
  RxBool isJoined = false.obs;
  RxBool isAvailable = true.obs;
  RxBool canBuy = true.obs;
  RxBool isTournament = true.obs;
  RxBool isBookmarked = true.obs;
  RxBool isLoading = true.obs;
  Rx<Game> game = (Get.arguments as Game).obs;
  RxString result = ''.obs;
  RxString link = ''.obs;
  GamesController gamesController = Get.find<GamesController>();
  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    fetchGame();
  }

  Future<void> fetchGame() async {
    isLoading.value = true;
    game.value = await gamesController.getGame(game.value.id);

    final gameData = game.value;
    final userId = userController.uid.value;

    isTournament.value = gameData.tournamentId?.isNotEmpty == true &&
        gameData.roundId?.isNotEmpty == true;

    canBuy.value = gameData.amount <= userController.coins.value;

    isCreator.value = gameData.creator == userId;

    isJoined.value = gameData.player_1 == userId || gameData.player_2 == userId;

    isAvailable.value = gameData.player_2.isEmpty;

    result.value =
        (gameData.player_1 == userId ? gameData.result_1 : gameData.result_2) ??
            '';

    link.value =
        (gameData.player_1 == userId ? gameData.link_1 : gameData.link_2) ?? '';

    isBookmarked.value = userController.gamesBookmarked.contains(gameData.id);
    isLoading.value = false;
  }

  Future<void> updateStatus(String result, String link) async {
    this.result.value = result;
    this.link.value = link;
    await gamesController.updateGame(game.value.id, userController.uid.value,
        link, result, game.value.player_1 == userController.uid.value);
  }

  Future<void> joinGame() async {
    await fetchGame();
    if (!isAvailable.value ||
        isJoined.value ||
        !canBuy.value ||
        isTournament.value) {
      return;
    }

    await gamesController.joinGame(game.value.id, userController.uid.value);
    userController.addGamePlayed(game.value.id);
    userController.addCoins(-game.value.amount);
    isJoined.value = true;
  }

  Future<void> chat() async {
    ChatsController chatController = Get.put(ChatsController());
    bool isCreator = game.value.creator == userController.uid.value;
    String player_2 =
        isCreator ? game.value.player_2 : userController.uid.value;
    String player_1 = game.value.creator!;
    String gameId = game.value.id;

    String chatId = gameId + player_1 + player_2;

    if (userController.chats.contains(chatId)) {
      Chat chat =
          chatController.chats.firstWhere((element) => element.id == chatId);
      Get.toNamed(Routes.CHAT, arguments: chat);
      return;
    } else {
      userController.addChat(chatId);
      await Profile.addChatToUser(isCreator ? player_2 : player_1, chatId);
      Get.toNamed(Routes.CHAT,
          arguments:
              await chatController.chatWithUser(player_2, player_1, gameId));
    }
  }

  Future<void> toggleButton() async {
    debugPrint(
        'Toggle Button Pressed isCreator: ${isCreator.value} isJoined: ${isJoined.value} isAvailable: ${isAvailable.value} canBuy: ${canBuy.value} isTournament: ${isTournament.value}');
    if (isCreator.value) {
      isJoined.value = !isJoined.value;
    } else if (!isAvailable.value) {
      customDialog(
        'Game Full',
        'This game is already full',
        'Ok',
        null,
        () {
          Get.back();
        },
        () {},
      );
      return;
    } else if (!canBuy.value) {
      customDialog(
        'Insufficient Coins',
        'You do not have enough coins to join this game: ${userController.coins.value}/${game.value.amount} coins',
        'Ok',
        null,
        () {
          Get.back();
        },
        () {},
      );
    } else if (isTournament.value) {
      customDialog(
        'Game is a part of Tournament',
        'You cannot join this game as it is a part of a tournament',
        'Ok',
        null,
        () async {
          Get.back();
        },
        () {},
      );
    } else if (!isJoined.value) {
      customDialog(
        'Join Game',
        'Are you sure you want to join this game? You will be required to pay ${game.value.amount} coins',
        'Yes',
        'No',
        () async {
          await joinGame();

          Get.back();
        },
        () {
          Get.back();
        },
      );
    }
  }

  Future<void> toggleBookmark() async {
    if (isBookmarked.value) {
      userController.removeGameBookmarked(game.value.id);
    } else {
      userController.addGameBookmarked(game.value.id);
    }
    isBookmarked.toggle();
  }

  String getButtonText() {
    return isCreator.value
        ? 'Toggle Details'
        : isJoined.value
            ? 'Joined'
            : isAvailable.value
                ? canBuy.value
                    ? 'Accept'
                    : 'Insufficient Coins'
                : 'Full';
  }
}
