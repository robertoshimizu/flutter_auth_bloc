import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageSender;
  String messageReceiver;
  DateTime messageDate;
  ChatMessage({
    @required this.messageContent,
    @required this.messageSender,
    @required this.messageReceiver,
    @required this.messageDate,
  });
  ChatMessage.fromMap(Map snapshot)
      : messageSender = snapshot['sender'],
        messageReceiver = snapshot['receiver'],
        messageDate = DateTime.fromMicrosecondsSinceEpoch(
            snapshot['date'].microsecondsSinceEpoch),
        messageContent = snapshot['content'];

  toJson() {
    return {
      "sender": messageSender,
      "receiver": messageReceiver,
      "date": messageDate,
      "content": messageContent
    };
  }
}
