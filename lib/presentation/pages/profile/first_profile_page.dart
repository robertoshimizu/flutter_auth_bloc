import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';

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

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser user = _authRepository.user;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
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
                      Text(
                        'Qual seu nome?',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 50.0,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          validator: validateName,
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.2,
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      startButtons(Color(0xff84BC75), 'próxima', context, () {
                        if (_formKey.currentState.validate()) {
                          var userdata = UserData(
                            uid: user.uid,
                            mobilePhone1: user.mobilePhone,
                            name: name,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaginaNascimento(
                                      userdata: userdata,
                                    )),
                          );
                        }
                      }),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      GestureDetector(
                        child: Center(
                          child: Text(
                            "Cancelar",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                        onTap: () {
                          _authRepository.logout();
                        },
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

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Por favor entre com seu nome';
    }
    name = value;
    return null;
  }
}

class PaginaCPF extends StatefulWidget {
  final UserData userdata;

  const PaginaCPF({Key key, @required this.userdata}) : super(key: key);
  @override
  _PaginaCPFState createState() => _PaginaCPFState();
}

final AuthRepository _authRepository = locator<DataAuthRepository>();

class _PaginaCPFState extends State<PaginaCPF> {
  final _formKey = GlobalKey<FormState>();
  String cpf;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserData userdata = widget.userdata;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
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
                      Text(
                        'Qual seu CPF?',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 50.0,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          validator: validateCpf,
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.2,
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      startButtons(Color(0xff84BC75), 'próxima', context, () {
                        if (_formKey.currentState.validate()) {
                          userdata.cpf = cpf;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdicionaFoto(
                                      userdata: userdata,
                                    )),
                          );
                        }
                      }),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      GestureDetector(
                        child: Center(
                          child: Text(
                            "Cancelar",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                        onTap: () {
                          _authRepository.logout();
                        },
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
}

class PaginaNascimento extends StatefulWidget {
  final UserData userdata;

  const PaginaNascimento({Key key, @required this.userdata}) : super(key: key);
  @override
  PaginaNascimentoState createState() => PaginaNascimentoState();
}

class PaginaNascimentoState extends State<PaginaNascimento> {
  final _formKey = GlobalKey<FormState>();

  String birthDate;

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    UserData userdata = widget.userdata;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
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
                      Text(
                        'Qual sua data de nascimento?',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 50.0,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'dd/mm/aaaa',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          validator: validatebirthDate,
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.2,
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      startButtons(Color(0xff84BC75), 'próxima', context, () {
                        if (_formKey.currentState.validate()) {
                          userdata.birthdate = birthDate;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaginaCPF(
                                      userdata: userdata,
                                    )),
                          );
                        }
                      }),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      GestureDetector(
                        child: Center(
                          child: Text(
                            "Cancelar",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                        onTap: () {
                          _authRepository.logout();
                        },
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
}

class AdicionaFoto extends StatelessWidget {
  final UserData userdata;
  AdicionaFoto({Key key, @required this.userdata}) : super(key: key);

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
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
              Text(
                'Vamos adicionar uma foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Escolha uma opção',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              startButtons(
                Color(0xff71196F),
                'fotografar',
                context,
                () {
                  Navigator.pushNamed(context, 'first_profile1');
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              startButtons(
                Color(0xff008FCA),
                'rolo da camera',
                context,
                () {
                  Navigator.pushNamed(context, 'first_profile1');
                },
              ),
              SizedBox(
                height: size.width * 0.08,
              ),
              GestureDetector(
                child: Center(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ),
                onTap: () {
                  _authRepository.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
