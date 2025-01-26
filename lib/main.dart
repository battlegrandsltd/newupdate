import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/authentication_controller.dart';
import 'package:playground/app/controllers/chat_controller.dart';
import 'package:playground/app/controllers/database_controller.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/controllers/notification_controller.dart';
import 'package:playground/app/controllers/lock_controller.dart';
import 'package:playground/app/controllers/medal_controller.dart';
import 'package:playground/app/controllers/payment_gateway_controller.dart';
import 'package:playground/app/controllers/tournament_controller.dart';
import 'package:playground/app/controllers/round_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/controllers/local_database_controller.dart';
import 'app/controllers/top_games_controller.dart';
import 'app/resources/theme_manager.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(DatabaseController());
  Get.put(AuthenticationController());
  Get.put(NotificationController());
  Get.put(UserController());
  Get.put(GamesController());
  Get.put(TournamentController());
  Get.put(RoundController());
  Get.put(TopGamesController());
  Get.put(MedalController());
  Get.put(ChatsController());
  await Get.put(LocalDatabaseController()).initialize();
  Get.put(LockController());
  Get.put(PaymentGatewayController());

  runApp(GetMaterialApp(
    title: "Battlegrands",
    debugShowCheckedModeBanner: false,
    theme: getApplicationTheme(),
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));
}
