import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repository/repositories.dart';
import '../../../locator.dart';

import '../../bloc/bloc.dart';
import '../pages.dart';

import 'main_drawer.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: Text('Página Principal'),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: MainDrawer(),
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
                                  'Solicitações de Indicações',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.pushNamed(
                                    context, 'needRequest_screen'),
                              ),
                              new ElevatedButton(
                                child: new Text(
                                  'Minhas Indicações',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: null,
                              ),
                              new ElevatedButton(
                                  child: new Text(
                                    'Applications',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: null),
                              new ElevatedButton(
                                child: new Text(
                                  'Chat',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage())),
                              )
                            ],
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
      ),
    );
  }
}
