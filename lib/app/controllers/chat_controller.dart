import 'package:get/get.dart';
import 'package:playground/app/controllers/database_controller.dart';

import '../data/models/chat.dart';

class ChatsController extends GetxController {
  List<Chat> chats = <Chat>[].obs;
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  @override
  void onInit() {
    super.onInit();
    getChats();
  }

  void getChats() async {
    dynamic result = await _databaseController.getData('chats');
    if (result != null) {
      chats = result.values
          .map<Chat>((chatMap) {
            return Chat.fromMap(chatMap);
          })
          .where((chat) => chat != null)
          .toList();
    }
  }

  Future<Chat> getChat(String id) async {
    dynamic result = await _databaseController.getData('chats/$id');
    return Chat.fromMap(result);
  }

  Future<List<Chat>> getUserChats(List<String> chatsIds) {
    return Future.wait(chatsIds.map((chatId) => getChat(chatId)));
  }

  Future<void> addChat(Chat chat) async {
    chats.add(chat);
    await _databaseController.setData('chats/${chat.id}', chat.toMap());
  }

  void updateChat(String chatId, int messageIndex) async {
    await _databaseController
        .updateData('chats/$chatId/messages/$messageIndex', {'isRead': true});
  }

  Future<void> addMessage(Message message, String chatId) async {
    Chat chat = await getChat(chatId);
    chat.messages.add(message);
    await _databaseController.setData('chats/$chatId', chat.toMap());
  }

  Future<Chat> chatWithUser(String user, String creator, String gameId) async {
    Chat chat = Chat(
      id: gameId + creator + user,
      user_1: creator,
      user_2: user,
      gameId: gameId,
      messages: <Message>[],
    );
    await addChat(chat);
    return chat;
  }
}
