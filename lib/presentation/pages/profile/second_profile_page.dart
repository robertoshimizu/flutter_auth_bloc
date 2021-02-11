import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../locator.dart';
import '../pages.dart';

class FirstProfile2 extends StatefulWidget {
  @override
  _FirstProfile2State createState() => _FirstProfile2State();
}

class _FirstProfile2State extends State<FirstProfile2> {
  DataUserRepository api = locator<DataUserRepository>();
  final AuthRepository _authRepository = locator<DataAuthRepository>();
  final _formKey = GlobalKey<FormState>();
  String nickname;
  @override
  Widget build(BuildContext context) {
    AppUser user = _authRepository.user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        padding: EdgeInsets.all(5.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Estamos quase lá!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Com esse @ as pessoas vão poder te encontrar. Você pode deixar do seu jeito.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor entre com seu nome';
                          }
                          nickname = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width * 0.85,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)),
                        onPressed: () {
                          // if (_formKey.currentState.validate()) {
                          //   api.updateUserfield(
                          //       id: user.uid, key: 'nickname', value: nickname);
                          // }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstProfile3()));
                        },
                        child: Text(
                          "Avançar",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xFF00B878),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
