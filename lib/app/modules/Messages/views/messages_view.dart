import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playground/app/controllers/chat_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/chat.dart';
import 'package:playground/app/data/models/profile.dart';
import 'package:playground/app/routes/app_pages.dart';
import '../../../resources/color_manager.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    ChatsController chatController = Get.find<ChatsController>();
    UserController userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Message',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const Icon(Icons.mail,
                          size: 40, color: ColorManager.primary),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            ' ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                // height: Get.height * 0.7,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: ColorManager.background2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: ColorManager.lightGrey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: ColorManager.lightGrey.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: FutureBuilder(
                          future:
                              chatController.getUserChats(userController.chats),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text(
                                  'No messages',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                            var chats = snapshot.data as List<Chat>;
                            int unreadCount = 0;
                            try {
                              unreadCount = chats
                                  .map((e) => e.messages
                                      .where((element) =>
                                          element.senderId !=
                                              userController.uid.value &&
                                          element.isRead == false)
                                      .length)
                                  .reduce((value, element) => value + element);
                            } catch (e) {
                              unreadCount = 0;
                            }
                            return Column(
                              children: [
                                Text(
                                  '$unreadCount unread messages',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: ListView(
                                    children: List.generate(
                                      snapshot.data!.length,
                                      (index) {
                                        return MessageItem(
                                          id: snapshot.data![index].user_1 ==
                                                  userController.uid.value
                                              ? snapshot.data![index].user_2
                                              : snapshot.data![index].user_1,
                                          chat: snapshot.data![index],
                                          unreadCount: snapshot
                                              .data![index].messages
                                              .where((element) =>
                                                  element.senderId !=
                                                      userController
                                                          .uid.value &&
                                                  element.isRead == false)
                                              .length,
                                        );
                                      },
                                    ).reversed.toList(),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final String id;
  final Chat chat;
  final int unreadCount;

  const MessageItem({
    super.key,
    required this.id,
    required this.chat,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder(
          future: Profile.findUser(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return const SizedBox();
            }
            Profile user = snapshot.data!;
            String displayTime = '';
            String message = '';
            try {
              DateTime time = DateTime.parse(chat.messages.last.time);
              displayTime = time.toString();
              if (DateTime.now().difference(time).inDays < 1) {
                displayTime = DateFormat.jm().format(time);
              } else if (DateTime.now().difference(time).inDays < 7) {
                displayTime = DateFormat.E().format(time);
              } else {
                displayTime = DateFormat.yMd().format(time);
              }
              message = chat.messages.last.message;
            } catch (e) {
              displayTime = '';
              message = 'Conversation started';
            }

            return InkWell(
              onTap: () async {
                ChatsController chatController = Get.find<ChatsController>();

                Get.offAndToNamed(Routes.CHAT,
                    arguments: await chatController.getChat(chat.id));
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/user avatar (${user.photo}).png"),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            displayTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          if (unreadCount > 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$unreadCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: ColorManager.lightGrey,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
