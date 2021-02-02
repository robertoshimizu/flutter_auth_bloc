import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/auth_repository.dart';
import '../../bloc/bloc.dart';

class HomePage extends StatelessWidget {
  final AuthRepository authRepository;

  HomePage({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
