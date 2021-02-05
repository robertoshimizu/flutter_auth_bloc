import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locator.dart';
import '../../bloc/bloc.dart';
import 'main_drawer.dart';

class HomePage extends StatelessWidget {
  final AppUser _user;
  final UserRepository _userRepository = locator<FirestoreService>();
  HomePage(this._user);

  @override
  Widget build(BuildContext context) {
    print(_user.props);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: MainDrawer(_user),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(Logout());
                },
              ),
            ),
            FutureBuilder(
              future: _userRepository.getUserById(_user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var username = snapshot.data['name'];
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Existing User: $username',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Did not load userData',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New User -> needs to fill profile',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
