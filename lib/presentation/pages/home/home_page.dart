import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/pages/mock/mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repository/repositories.dart';
import '../../../locator.dart';

import '../../bloc/bloc.dart';
import '../pages.dart';

class HomePage extends StatelessWidget {
  final AuthRepository _authRepository = locator<DataAuthRepository>();
  final UserRepository _userRepository = locator<DataUserRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser _user = _authRepository.user;
    print('user props: ${_user.props}');
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print('AuthBloc listener: $state');
        if (state is Uninitialized) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }
      },
      child: FutureBuilder(
        future: _userRepository.getUserById(_user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var username = snapshot.data['name'];
            return MainMenu(username: username);
          } else if (snapshot.hasError) {
            return ErrorMenu();
          } else {
            return FirstProfile1();
          }
        },
      ),
    );
  }
}

class ErrorMenu extends StatelessWidget {
  const ErrorMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key key,
    @required this.username,
  }) : super(key: key);

  final username;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Usuário Logado: $username',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 15.0),
          ButtonBar(
            mainAxisSize: MainAxisSize
                .min, // this will take space as minimum as posible(to center)
            children: <Widget>[
              new ElevatedButton(
                child: new Text(
                  'Solicitações de Indicações da rede',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, 'needRequest_screen'),
              ),
              new ElevatedButton(
                child: new Text(
                  'Minhas solicitações de indicações',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, 'myNeedRequest_screen'),
              ),
              new ElevatedButton(
                child: new Text(
                  'Minhas Indicações',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyIndications())),
              ),
              new ElevatedButton(
                child: new Text(
                  'Master',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Master())),
              ),
              new ElevatedButton(
                child: new Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage())),
              )
            ],
          ),
        ],
      ),
    );
  }
}
