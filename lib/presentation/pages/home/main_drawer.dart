import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';

import '../../../locator.dart';

class MainDrawer extends StatelessWidget {
  final AppUser user;
  final UserRepository qqeur = locator<DataUserRepository>();
  MainDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
          future: qqeur.getUserById(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var username = snapshot.data["name"];
              // var occupation = snapshot.data["occupation"];
              var photo = snapshot.data["photo"];
              // print(username);
              return Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: Color(0xFF353B4E),
                    // color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 30,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    photo,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'occupation',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF353B4E),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 115,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '242',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'pontuação',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '51',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'conexões',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '15',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'participações',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Color(0xFF353B4E),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.pushNamed(context, 'home_screen');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Configurar perfil',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            // Navigator.of(context).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Profile()));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.contacts,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Meus Contatos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.pushNamed(context, 'mycontacts_screen');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.contacts,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Convidar Amigos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            // Navigator.of(context).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => InviteNewFriends()));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Sair',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Splash()));
                            // await _auth.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
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
          }),
    );
  }
}
