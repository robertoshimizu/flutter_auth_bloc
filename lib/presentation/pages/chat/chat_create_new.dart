import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class NewChat extends StatelessWidget {
  final AuthRepository _authRepository = locator<DataAuthRepository>();
  @override
  Widget build(BuildContext context) {
    var selectedFriend = Provider.of<MyContactSelection>(context).selectedId;
    var _user = _authRepository.user;

    if (selectedFriend.isEmpty) {
      return SelectOneContact();
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Provider.of<MyContactSelection>(context, listen: false)
                    .clearContactSelection();
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 55.0,
            ),
            child: Column(
              children: [
                Text('Create New Chat between: '),
                Text('Friend Selected: ${selectedFriend[0]}'),
                Text('Current User: ${_user.uid}'),
              ],
            ),
          ),
        ),
      );
    }
  }
}
