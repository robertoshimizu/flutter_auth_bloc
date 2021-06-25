import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../locator.dart';

class FirstProfile1 extends StatefulWidget {
  @override
  _FirstProfile1State createState() => _FirstProfile1State();
}

class _FirstProfile1State extends State<FirstProfile1> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String birthDate;
  String cpf;
  DataUserRepository api = locator<DataUserRepository>();
  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser user = _authRepository.user;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 38.0,
                ),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/lockup-eu-indico.png'),
                    height: size.height * 0.16,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome Completo',
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        validator: validateName,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Data de nascimento (dd/mm/aaaa)',
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        validator: validatebirthDate,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Número de CPF',
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        validator: validateCpf,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width * 0.85,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            var userdata = UserData(
                              uid: user.uid,
                              mobilePhone1: user.mobilePhone,
                              name: name,
                              birthdate: birthDate,
                              cpf: cpf,
                              registered: DateTime.now(),
                            );

                            Navigator.pushNamed(
                              context,
                              'first_profile2',
                              arguments: userdata,
                            );
                          }
                        },
                        child: const Text(
                          "Avançar",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xFF00B878),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Ao avançar, declaro que li e aceito as políticas de privacidade e os termos de uso',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
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

  String validatebirthDate(String value) {
    RegExp pattern;
    if (value.isEmpty) {
      return 'Por favor entre com sua data de nascimento';
    } else {
      pattern = new RegExp(
          r'([0-2][0-9]|(3)[0-1])[\/](((0)[0-9])|((1)[0-2]))[\/]\d{4}');
      if (!pattern.hasMatch(value)) {
        return 'Entre com uma Data de Nascimento válida';
      } else
        birthDate = value;
      return null;
    }
  }

  String validateCpf(String value) {
    RegExp pattern;
    if (value.isEmpty) {
      return 'Por favor entre com seu CPF';
    } else {
      pattern = new RegExp(
          r'([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})');
      if (!pattern.hasMatch(value)) {
        return 'Entre com um CPF válido';
      } else if (!CPF.isValid(value)) {
        return 'Entre com um CPF válido';
      } else
        print(CPF.format(value));
      cpf = value;
      return null;
    }
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Por favor entre com seu nome';
    }
    name = value;
    return null;
  }
}
