import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class NewChat extends StatelessWidget {
  final String friend;
  NewChat(this.friend);

  final AuthRepository _authRepository = locator<DataAuthRepository>();
  final DataChatRepository qqeur = DataChatRepository();
  @override
  Widget build(BuildContext context) {
    var selectedFriend = Provider.of<MyContactSelection>(context).selectedId;
    var _user = _authRepository.user;
    print('Friend: $friend');

    if (selectedFriend.isEmpty && friend == null) {
      return SelectOneContact();
    } else {
      var s = (friend == null) ? '${selectedFriend[0]}' : friend;
      print('S: $s');
      return FutureBuilder(
          future: qqeur.verifyChatId(s, _user.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              var chat = qqeur.registerChatId(s, _user.uid);
              Provider.of<MyContactSelection>(context, listen: false)
                  .clearContactSelection();
              return ChatDetailPage(chat: chat);
            } else if (snapshot.hasData) {
              var chat = snapshot.data;
              Provider.of<MyContactSelection>(context, listen: false)
                  .clearContactSelection();
              return ChatDetailPage(chat: chat);
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
}

// bool chatIdExist =
//           await qqeur.verifyChatId('${selectedFriend[0]}', '${_user.uid}');
//       if (!chatIdExist) {
//         var chatId =
//             qqeur.registerChatId('${selectedFriend[0]}', '${_user.uid}');
//         Provider.of<MyContactSelection>(context, listen: false)
//             .clearContactSelection();
//         // Navigator.pop(context);
//         return ChatDetailPage(chatId: chatId);
//       } else {
//         var chatId = qqeur.getChatId('${selectedFriend[0]}', '${_user.uid}');
//         return ChatDetailPage(chatId: chatId);
//       }
//     }
