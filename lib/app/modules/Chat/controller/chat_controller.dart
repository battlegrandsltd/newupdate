import 'package:get/get.dart';
import 'package:playground/app/data/models/chat.dart';

class ChatController extends GetxController {
  Rx<Chat> chat = (Get.arguments as Chat).obs;
}
