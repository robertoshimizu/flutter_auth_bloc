import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../locator.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages;
  //  = [
  //   ChatMessage(
  //     messageContent: "Hello, Orr",
  //     messageSender: "5eb9628e08e7a36ab6141444",
  //     messageReceiver: "5eb9628e015a6a5c21dd85c9",
  //     messageDate: DateTime.parse("2021-02-17 20:18:00"),
  //   ),
  //   ChatMessage(
  //     messageContent: "How have you been?",
  //     messageSender: "5eb9628e08e7a36ab6141444",
  //     messageReceiver: "5eb9628e015a6a5c21dd85c9",
  //     messageDate: DateTime.parse("2021-02-17 20:19:10"),
  //   ),
  //   ChatMessage(
  //     messageContent: "Hey Leanna, I am doing fine dude. wbu?",
  //     messageSender: "5eb9628e015a6a5c21dd85c9",
  //     messageReceiver: "5eb9628e08e7a36ab6141444",
  //     messageDate: DateTime.parse("2021-02-17 20:20:20"),
  //   ),
  //   ChatMessage(
  //     messageContent: "ehhhh, doing OK.",
  //     messageSender: "5eb9628e08e7a36ab6141444",
  //     messageReceiver: "5eb9628e015a6a5c21dd85c9",
  //     messageDate: DateTime.parse("2021-02-17 20:21:30"),
  //   ),
  //   ChatMessage(
  //     messageContent: "Is there any thing wrong?",
  //     messageSender: "5eb9628e015a6a5c21dd85c9",
  //     messageReceiver: "5eb9628e08e7a36ab6141444",
  //     messageDate: DateTime.parse("2021-02-17 20:22:00"),
  //   ),
  // ];
  final DataChatRepository qqeur = DataChatRepository();
  @override
  Widget build(BuildContext context) {
    // print('to aqui');
    // messages.forEach((element) {
    //   qqeur.sendMessage(element);
    //   print(element.toJson());
    // });
    // qqeur.sendMessage();
    qqeur.fetchMessages("5eb9628e015a6a5c21dd85c9", "5eb9628e08e7a36ab6141444");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                // CircleAvatar(
                //   backgroundImage: ,
                //   maxRadius: 20,
                // ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kriss Benwat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<Object>(
              stream: qqeur.fetchMessagesAsStream(
                  "5eb9628e015a6a5c21dd85c9", "5eb9628e08e7a36ab6141444"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  messages = snapshot.data;
                  print('num of messages: ${messages.length}');
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageReceiver ==
                                  "5eb9628e015a6a5c21dd85c9"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageReceiver ==
                                      "5eb9628e015a6a5c21dd85c9"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'error',
                    style: TextStyle(fontSize: 20.0),
                  );
                } else {
                  print('modo wait');
                  return Text('Não há nenhuma requisição na plataforma');
                }
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
