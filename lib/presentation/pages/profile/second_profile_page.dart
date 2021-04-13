import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

import '../pages.dart';

class FirstProfile2 extends StatelessWidget {
  final UserData user;
  FirstProfile2({
    Key key,
    @required this.user,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  static const routeName = '/first_profile2';

  @override
  Widget build(BuildContext context) {
    String nickname;
    print('Passou User?????: ${user.name}');
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
                          if (_formKey.currentState.validate()) {
                            user.nick = nickname;
                          }

                          Navigator.pushNamed(
                            context,
                            'first_profile3',
                            arguments: user,
                          );
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
