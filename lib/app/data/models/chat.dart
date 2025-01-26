class Chat {
  final String id;
  final String user_1;
  final String user_2;
  List<Message> messages;
  final String gameId;

  Chat(
      {required this.user_1,
      required this.messages,
      required this.user_2,
      required this.gameId,
      required this.id});

  factory Chat.fromMap(dynamic map) {
    return Chat(
      id: map['id'],
      user_1: map['user_1'],
      user_2: map['user_2'],
      gameId: map['gameId'],
      messages: map['messages'] == null
          ? []
          : List<Message>.from(map['messages'].map((x) => Message.fromMap(x))),
    );
  }

  dynamic toMap() {
    return {
      'id': id,
      'user_1': user_1,
      'user_2': user_2,
      'gameId': gameId,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }
}

class Message {
  final String senderId;
  final String message;
  final String time;
  bool isRead = false;

  Message(
      {required this.senderId,
      required this.message,
      required this.time,
      required this.isRead});

  factory Message.fromMap(dynamic map) {
    return Message(
      senderId: map['senderId'],
      message: map['message'],
      time: map['time'].toString(),
      isRead: map['isRead'] ?? false,
    );
  }

  dynamic toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'time': time,
      'isRead': isRead,
    };
  }
}
