import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../locator.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;

  const ChatDetailPage({Key key, @required this.chat}) : super(key: key);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final AuthRepository _authRepository = locator<DataAuthRepository>();

  List<ChatMessage> messages;

  final DataChatRepository qqeur = DataChatRepository();
  @override
  Widget build(BuildContext context) {
    AppUser user = _authRepository.user;
    var otherUser =
        user.uid == widget.chat.user1 ? widget.chat.user2 : widget.chat.user1;
    // print('to aqui');
    // qqeur.registerChatId(
    //     '5eb9628e08e7a36ab6141444', '5eb9628e4e07793d5a79908b');
    // messages.forEach((element) {
    //   qqeur.sendMessage(element);
    //   print(element.toJson());
    // });
    // qqeur.sendMessage();
    qqeur.fetchMessages(widget.chat.chatId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: ChatDetailHeadline(
            user: otherUser,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: StreamBuilder<Object>(
                stream:
                    qqeur.fetchMessagesAsStream(widget.chat.chatId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    messages = snapshot.data;
                    print('num of messages: ${messages.length}');
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messages[index].messageReceiver ==
                                    widget.chat.user1
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messages[index].messageReceiver ==
                                        widget.chat.user1
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
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ChatMessageBlock(),
          ),
        ],
      ),
    );
  }
}

class ChatDetailHeadline extends StatelessWidget {
  final String user;
  ChatDetailHeadline({Key key, @required this.user}) : super(key: key);

  final UserRepository qqeur = locator<DataUserRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: qqeur.getUserById(user),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var user2 = UserData.fromMap(snapshot.data, user);
            return Container(
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(user2.photo),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user2.name,
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
            );
          } else if (snapshot.hasError) {
            return Text(
              'error',
              style: TextStyle(fontSize: 20.0),
            );
          } else
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ],
              ),
            );
        });
  }
}

class ChatMessageBlock extends StatefulWidget {
  const ChatMessageBlock({
    Key key,
  }) : super(key: key);

  @override
  _ChatMessageBlockState createState() => _ChatMessageBlockState();
}

class _ChatMessageBlockState extends State<ChatMessageBlock> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      color: Colors.grey,
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
              controller: messageController,
              minLines: 1,
              maxLines: 5,
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
            onPressed: () {
              print(messageController.text);
            },
            mini: true,
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
    );
  }
}

//  = [
//   ChatMessage(
//     messageContent: "Hello, Harriet",
//     messageSender: "5eb9628e08e7a36ab6141444",
//     messageReceiver: "5eb9628e4e07793d5a79908b",
//     messageDate: DateTime.parse("2021-02-07 20:18:00"),
//   ),
//   ChatMessage(
//     messageContent: "How have you been?",
//     messageSender: "5eb9628e4e07793d5a79908b",
//     messageReceiver: "5eb9628e08e7a36ab6141444",
//     messageDate: DateTime.parse("2021-02-08 20:19:10"),
//   ),
//   ChatMessage(
//     messageContent: "Hey Leanna, I am doing fine dude. wbu?",
//     messageSender: "5eb9628e08e7a36ab6141444",
//     messageReceiver: "5eb9628e4e07793d5a79908b",
//     messageDate: DateTime.parse("2021-02-09 20:20:20"),
//   ),
//   ChatMessage(
//     messageContent: "ehhhh, doing OK.",
//     messageSender: "5eb9628e4e07793d5a79908b",
//     messageReceiver: "5eb9628e08e7a36ab6141444",
//     messageDate: DateTime.parse("2021-02-10 20:21:30"),
//   ),
//   ChatMessage(
//     messageContent: "Is there any thing wrong?",
//     messageSender: "5eb9628e08e7a36ab6141444",
//     messageReceiver: "5eb9628e4e07793d5a79908b",
//     messageDate: DateTime.parse("2021-02-11 20:22:00"),
//   ),
// ];
