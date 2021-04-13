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

  Future<void> updateUserfield({String id, String key, dynamic value}) async {
    await _api.updateDocumentField(id: id, key: key, value: value);
    return;
  }
}

class DataChatRepository with ChangeNotifier {
  CollectionReference _api = FirebaseFirestore.instance.collection('messages');
  List<ChatMessage> chat;

  Chat registerChatId(String sender, String receiver) {
    var chatId = getChatId(sender, receiver);
    var chat = Chat(
      chatId: chatId,
      createdAt: new DateTime.now(),
      user1: sender,
      user2: receiver,
    );

    _api
        .doc(chatId)
        .set(chat.toJson())
        .then((value) => print("New Chat Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return chat;
  }

  Future<void> sendMessage(ChatMessage message) {
    var chatId = getChatId(message.messageSender, message.messageReceiver);
    _api
        .doc(chatId)
        .collection(chatId)
        .add(message.toJson())
        .then((value) => print("Message Confirmed: $value"))
        .catchError((error) => print("Failed to send message: $error"));

    return null;
  }

  Future<List<ChatMessage>> fetchMessages(String chatId) async {
    // var chatId = getChatId(sender, receiver);
    var result = await _api.doc(chatId).collection(chatId).get();

    chat = result.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();

    // print('chat length: ${chat.length}');

    return chat;
  }

  Stream<List<ChatMessage>> fetchMessagesAsStream(String chatId) {
    var result = _api.doc(chatId).collection(chatId).snapshots();

    var requests = result.map((event) =>
        event.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList());

    return requests;
  }

  Stream<List<Map<String, dynamic>>> fetchConversationsAsStream(
      String currentId) {
    var result = FirebaseFirestore.instance.collection('messages').snapshots();

    // filter to only chats in which currentID is in //
    var requests = result.map((event) {
      var lista = event.docs.map((doc) {
        var chatId = (doc.data()['chatId']).toString();
        if (chatId.contains(currentId.hashCode.toString())) {
          return doc.data();
        } else {
          return null;
        }
      }).toList();
      // print('lista ANTES: $lista');
      lista.removeWhere((item) => item == null);
      // print('lista DEPOIS: $lista');

      return lista;
    });

    return requests;
  }

  String getChatId(firstId, secondId) {
    if (firstId.hashCode <= secondId.hashCode) {
      return '${firstId.hashCode}-${secondId.hashCode}';
    } else {
      return '${secondId.hashCode}-${firstId.hashCode}';
    }
  }

  Future<Chat> verifyChatId(String s, String t) async {
    var chatId = getChatId(s, t);
    var doc = await _api.doc(chatId).get();
    if (!doc.exists) {
      print('Chat Não existe');
      return null;
    }
    return Chat.fromMap(doc.data());
  }
}
