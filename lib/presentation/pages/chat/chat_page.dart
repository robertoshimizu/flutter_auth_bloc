import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';

import '../../../domain/entities/entities.dart';
import '../pages.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DataChatRepository qqeur = DataChatRepository();
  List<Map<String, dynamic>> requests;

  List<ChatMessage> messages = [
    ChatMessage(
      messageContent: "Hello, Harriet",
      messageSender: "5eb9628e63f04e0d51d43da3",
      messageReceiver: "5eb9628e17cb662d0ab6186e",
      messageDate: DateTime.parse("2021-02-07 20:18:00"),
    ),
    ChatMessage(
      messageContent: "How have you been?",
      messageSender: "5eb9628e17cb662d0ab6186e",
      messageReceiver: "5eb9628e63f04e0d51d43da3",
      messageDate: DateTime.parse("2021-02-08 20:19:10"),
    ),
    ChatMessage(
      messageContent: "Hey Leanna, I am doing fine dude. wbu?",
      messageSender: "5eb9628e63f04e0d51d43da3",
      messageReceiver: "5eb9628e17cb662d0ab6186e",
      messageDate: DateTime.parse("2021-02-09 20:20:20"),
    ),
    ChatMessage(
      messageContent: "ehhhh, doing OK.",
      messageSender: "5eb9628e17cb662d0ab6186e",
      messageReceiver: "5eb9628e63f04e0d51d43da3",
      messageDate: DateTime.parse("2021-02-10 20:21:30"),
    ),
    ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageSender: "5eb9628e63f04e0d51d43da3",
      messageReceiver: "5eb9628e17cb662d0ab6186e",
      messageDate: DateTime.parse("2021-02-11 20:22:00"),
    ),
  ];
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL: "https://randomuser.me/api/portraits/women/5.jpg",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: "https://randomuser.me/api/portraits/women/15.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "https://randomuser.me/api/portraits/men/9.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL: "https://randomuser.me/api/portraits/women/4.jpg",
        time: "23 Mar"),
    ChatUsers(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        imageURL: "https://randomuser.me/api/portraits/men/35.jpg",
        time: "17 Mar"),
    ChatUsers(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        imageURL: "https://randomuser.me/api/portraits/men/16.jpg",
        time: "24 Feb"),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "https://randomuser.me/api/portraits/men/32.jpg",
        time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    // qqeur.registerChatId(
    //     "5eb9628e63f04e0d51d43da3e", "5eb9628e17cb662d0ab6186e");
    // messages.forEach((element) {
    //   qqeur.sendMessage(element);
    //   print(element.toJson());
    // });

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade900,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            StreamBuilder<Object>(
                stream: qqeur
                    .fetchConversationsAsStream('5eb9628e015a6a5c21dd85c9'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('Snapshot Data: ${snapshot.data}');
                    requests = snapshot.data;
                    return ListView.builder(
                      itemCount: requests.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${requests[index]}'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatDetailPage(
                                        chatId: '184763751-936641347')));
                          },
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
                    return Text('Não há nenhuma conversa na plataforma');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
