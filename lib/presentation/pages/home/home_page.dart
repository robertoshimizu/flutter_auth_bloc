import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class HomePage extends StatelessWidget {
  final AppUser _user;
  HomePage(this._user);
  @override
  Widget build(BuildContext context) {
    print(_user.props);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${_user.mobilePhone}'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text('logout'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(Logout());
          },
        )),
      ),
    );
  }
}
