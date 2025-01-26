import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playground/app/controllers/chat_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/chat.dart';
import 'package:playground/app/modules/Chat/controller/chat_controller.dart';
import 'package:playground/app/modules/Messages/controllers/messages_controller.dart';
import 'package:playground/app/modules/widgets/custom_loading.dart';
import 'package:playground/app/routes/app_pages.dart';
import '../../../controllers/games_controller.dart';
import '../../../data/models/profile.dart';
import '../../../resources/color_manager.dart';

class ChatView extends GetView {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    UserController userController = Get.find<UserController>();
    ChatsController chatController = Get.find<ChatsController>();
    GamesController gamesController = Get.find<GamesController>();
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        scrolledUnderElevation: 0,
        title: FutureBuilder(
            future: Profile.findUser(
                controller.chat.value.user_1 == userController.uid.value
                    ? controller.chat.value.user_2
                    : controller.chat.value.user_1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/user avatar (${snapshot.data!.photo}).png",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    snapshot.data!.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.2,
            width: Get.width * 0.9,
            child: FutureBuilder(
              future: gamesController.getGame(controller.chat.value.gameId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoading(heightFactor: .2, widthFactor: 1);
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading game'));
                }
                return Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.MATCH_DETAIL,
                            arguments: snapshot.data,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            snapshot.data!.image,
                            width: Get.width * .8,
                            height: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                width: Get.width * .8,
                                height: 140,
                                child: const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: ColorManager.error,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return SizedBox(
                                width: Get.width * .8,
                                height: 140,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: Get.width * .8,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: List.generate(
                                  10,
                                  (index) => ColorManager.black
                                      .withOpacity(index * .1)),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                snapshot.data!.date,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance
                .ref('chats/${controller.chat.value.id}/messages'),
            controller: scrollController,
            itemBuilder: (context, snapshot, animation, index) {
              Map<String, dynamic> messageMap =
                  Map<String, dynamic>.from(snapshot.value as Map);
              Message message = Message.fromMap(messageMap);
              if (message.senderId != userController.uid.value) {
                message.isRead = true;
                chatController.updateChat(controller.chat.value.id, index);
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
              return ChatBubble(
                message: message,
                isMe: message.senderId == userController.uid.value,
              );
            },
          )),
          const ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(message.time);
    String displayTime = time.toString();
    if (DateTime.now().difference(time).inDays < 1) {
      displayTime = DateFormat.jm().format(time);
    } else if (DateTime.now().difference(time).inDays < 7) {
      displayTime = DateFormat.E().format(time);
    } else {
      displayTime = DateFormat.yMd().format(time);
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isMe ? ColorManager.primary : ColorManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      width: Get.width * 0.5,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        children: [
          if (isMe)
            Icon(
              message.isRead ? Icons.done_all : Icons.done,
              color: Colors.white,
              size: 16,
            ),
          const SizedBox(width: 8),
          Text(
            isMe ? displayTime : message.message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: isMe ? 12 : 16,
            ),
          ),
          const Spacer(),
          Text(
            isMe ? message.message : displayTime,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: isMe ? 16 : 12,
            ),
          ),
          const SizedBox(width: 8),
          if (!isMe)
            const Icon(
              Icons.done_all,
              color: Colors.black,
              size: 16,
            ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: ColorManager.background1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                // color: ColorManager.background2,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: ColorManager.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: ColorManager.primary),
                    )),
              ),
            ),
          ),
          // const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.send,
              size: 24,
            ),
            color: ColorManager.white,
            style: IconButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () async {
              if (textController.text.isEmpty) {
                return;
              }
              Message message = Message(
                senderId: Get.find<UserController>().uid.value,
                message: textController.text,
                time: DateTime.now().toString(),
                isRead: false,
              );
              var chatController = Get.find<ChatsController>();
              var controller = Get.find<ChatController>();

              await chatController.addMessage(
                  message, controller.chat.value.id);
              controller.chat.value =
                  await chatController.getChat(controller.chat.value.id);
              textController.clear();
              MessagesController messagesController =
                  Get.find<MessagesController>();
              messagesController.update();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
