import 'package:flutter/material.dart';

class Chat {
  DateTime createdAt;
  String chatId, user1, user2;
  Chat({
    @required this.chatId,
    @required this.createdAt,
    @required this.user1,
    @required this.user2,
  });

  Chat.fromMap(Map snapshot)
      : chatId = snapshot['chatId'],
        user1 = snapshot['user1'],
        createdAt = DateTime.fromMicrosecondsSinceEpoch(
            snapshot['createdAt'].microsecondsSinceEpoch),
        user2 = snapshot['user2'];

  toJson() {
    return {
      "chatId": chatId,
      "createdAt": createdAt,
      "user1": user1,
      "user2": user2
    };
  }
}
