import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/adapters/adapters.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

import '../../domain/repository/user_repository.dart';

class DataUserRepository with ChangeNotifier implements UserRepository {
  FirestoreService _api = FirestoreService('users');

  @override
  Future<Map> getUserById(String id) async {
    var doc = await _api.getDocumentById(id);
    if (!doc.exists) {
      return null;
    }
    return doc.data();
  }

  @override
  Future updateUserData(UserData data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future<void> createUser(Map<String, dynamic> values) async {
    String uid = values['uid'];
    await _api.createFirestoreUser(values, uid);
    return;
  }
}

class DataChatRepository with ChangeNotifier {
  CollectionReference _api = FirebaseFirestore.instance.collection('messages');
  List<ChatMessage> chat;
  Future<void> sendMessage(ChatMessage message) {
    var chatId = getChatId(message.messageSender, message.messageReceiver);
    return _api
        .doc(chatId)
        .collection(chatId)
        .add(message.toJson())
        .then((value) => print("Message Confirmed: $value"))
        .catchError((error) => print("Failed to send message: $error"));
  }

  Future<List<ChatMessage>> fetchMessages(
      String sender, String receiver) async {
    var chatId = getChatId(sender, receiver);
    var result = await _api.doc(chatId).collection(chatId).get();

    chat = result.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();

    print('chat length: ${chat.length}');

    return chat;
  }

  Stream<List<ChatMessage>> fetchMessagesAsStream(
      String sender, String receiver) {
    var chatId = getChatId(sender, receiver);
    var result = _api.doc(chatId).collection(chatId).snapshots();

    var requests = result.map((event) =>
        event.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList());

    return requests;
  }
}

getChatId(firstId, secondId) {
  if (firstId.hashCode <= secondId.hashCode) {
    return '$firstId-$secondId';
  } else {
    return '$secondId-$firstId';
  }
}
