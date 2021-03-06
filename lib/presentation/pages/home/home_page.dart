import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';

class HomePage extends StatelessWidget {
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
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedOut());
          },
        )),
      ),
    );
  }
}
