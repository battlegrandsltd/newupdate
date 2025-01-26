import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';

class NotificationController extends GetxController {
  static String? fcmToken;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  RxList<RemoteMessage> recentNotifications = <RemoteMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> init(BuildContext context) async {
    try {
      final UserController userController = Get.find();
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      fcmToken = await _fcm.getToken();
      userController.setFCMToken(fcmToken!);
      FirebaseMessaging.instance.subscribeToTopic('all');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleMessage(message);
      });

      FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

      if (kDebugMode) {
        debugPrint('FCM token: $fcmToken');
      }
    } catch (e) {
      debugPrint('Error initializing notification: $e');
    }
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint('Handling a message: ${message.messageId}');
    if (recentNotifications.length >= 10) {
      debugPrint('Removing oldest notification');
      recentNotifications.removeAt(0);
    }
    recentNotifications.add(message);
    saveNotifications();
    update();
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Handling a background message: ${message.messageId}');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(NotificationController())._handleMessage(message);
    debugPrint('Message handled');
  }

  Future<void> saveNotifications() async {
    debugPrint('Saving notifications');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = recentNotifications
        .map((msg) => jsonEncode({
              'title': msg.notification?.title,
              'body': msg.notification?.body,
              'data': msg.data,
              'time': DateTime.now().toIso8601String(),
            }))
        .toList();
    await prefs.setStringList('savedNotifications', jsonList);
  }

  Future<void> loadNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('savedNotifications') ?? [];
    recentNotifications.value = jsonList
        .map((string) {
          Map<String, dynamic> json = jsonDecode(string);
          return RemoteMessage(
            notification: RemoteNotification(
              title: json['title'],
              body: json['body'],
            ),
            data: json['data'] as Map<String, dynamic>,
            sentTime: DateTime.parse(json['time']),
          );
        })
        .toList()
        .reversed
        .toList();
  }
}
