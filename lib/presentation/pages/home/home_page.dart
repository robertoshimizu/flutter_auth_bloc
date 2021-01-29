import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final AuthRepository authRepository;

  HomePage({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppUser _user;
    _user = authRepository.user;
    // print('User dentro do HomePage: ${_user.mobilePhone}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text('logout'),
          onPressed: () async {
            await authRepository.logout();
            BlocProvider.of<AuthenticationBloc>(context).add(Logout());
          },
        )),
      ),
    );
  }
}
