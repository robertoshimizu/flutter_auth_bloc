import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';

import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../locator.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  int index = 0;
  //form values
  String _currentName;
  String _currentGender;
  String _currentOccupation;
  String _currentNickname;
  String _currentMobile1;
  String _currentCpf;
  String _currentAddress;
  String _currentIdType;
  String _currentId;
  String _currentAbout;

  final UserRepository qqeur = locator<DataUserRepository>();
  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser user = _authRepository.user;

    List<Map<dynamic, dynamic>> _categories = [
      {
        'menu': 'Editar',
        'icon': Icons.edit,
        'enabled': false,
      },
      {
        'menu': 'Salvar',
        'icon': Icons.save,
        'enabled': true,
      },
    ];

    return FutureBuilder(
        future: qqeur.getUserById(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = UserData.fromMap(snapshot.data, user.uid);

            return Scaffold(
              appBar: AppBar(
                title: Text('Profile Page'),
                actions: <Widget>[
                  TextButton(
                    //color: Colors.black,
                    //disabledTextColor: Colors.black,
                    child: Text(
                      _categories[index]['menu'],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (index == 0) {
                        setState(() {
                          index = 1;
                        });
                      } else if (index == 1) {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var updateUser = UserData(
                            uid: user.uid,
                            name: _currentName ?? userData.name,
                            mobilePhone1:
                                _currentMobile1 ?? userData.mobilePhone1,
                            address: _currentAddress ?? userData.address,
                            occupation:
                                _currentOccupation ?? userData.occupation,
                            idtype: _currentIdType ?? userData.idtype,
                            id: _currentId ?? userData.id,
                            gender: _currentGender ?? userData.gender,
                            about: _currentAbout ?? userData.about,
                            cpf: _currentCpf ?? userData.cpf,
                            nickname: _currentNickname ?? userData.nickname,
                            phone1: userData.phone1,
                            photo: userData.photo,
                            registered: userData.registered,
                            birthdate: userData.birthdate,
                          );
                          qqeur.updateUserData(updateUser, user.uid);

                          setState(() {
                            index = 0;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AvatarHeader(userData: userData),
                    Container(
                      // Body
                      width: double.infinity,
                      color: Color(0xECF0F3),
                      padding: EdgeInsets.all(5),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                //Sexo
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: // Nome
                                        TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Nome',
                                      ),
                                      initialValue: userData.name,
                                      onChanged: (value) => setState(
                                        () => _currentName = value,
                                      ),
                                    ),
                                  ),

                                  //ocupação
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Sexo',
                                      ),
                                      initialValue: userData.gender,
                                      onChanged: (value) => setState(
                                        () => _currentGender = value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                //Sexo
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Ocupação',
                                      ),
                                      initialValue: userData.occupation,
                                      onChanged: (value) => setState(
                                        () => _currentOccupation = value,
                                      ),
                                    ),
                                  ),

                                  //Companhia
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Apelido',
                                      ),
                                      initialValue: userData.nickname,
                                      onChanged: (value) => setState(
                                        () => _currentNickname = value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                //Sexo
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: //phone1
                                        TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Telefone Celular',
                                      ),
                                      initialValue: userData.mobilePhone1,
                                      onChanged: (value) => setState(
                                        () => _currentMobile1 = value,
                                      ),
                                    ),
                                  ),

                                  //ocupação
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'CPF',
                                      ),
                                      initialValue: userData.cpf,
                                      onChanged: (value) => setState(
                                        () => _currentCpf = value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //endereço
                              TextFormField(
                                enabled: _categories[index]['enabled'],
                                decoration: InputDecoration(
                                  labelText: 'Endereço',
                                ),
                                initialValue: userData.address,
                                onChanged: (value) => setState(
                                  () => _currentAddress = value,
                                ),
                              ),

                              //document
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Tipo Documento',
                                      ),
                                      initialValue: userData.idtype,
                                      onChanged: (value) => setState(
                                        () => _currentIdType = value,
                                      ),
                                    ),
                                  ),

                                  //document num
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _categories[index]['enabled'],
                                      decoration: InputDecoration(
                                        labelText: 'Número',
                                      ),
                                      initialValue: userData.id,
                                      onChanged: (value) => setState(
                                        () => _currentId = value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Sobre
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                enabled: _categories[index]['enabled'],
                                decoration: InputDecoration(
                                  labelText: 'Sobre',
                                ),
                                initialValue: userData.about,
                                onChanged: (value) => setState(
                                  () => _currentAbout = value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(
              'error',
              style: TextStyle(fontSize: 20.0),
            );
          } else {
            return Container(
              child: Center(
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
              ),
            );
          }
        });
  }
}

class AvatarHeader extends StatelessWidget {
  const AvatarHeader({
    Key key,
    @required this.userData,
  }) : super(key: key);

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      //Header
      padding: EdgeInsets.all(5),
      color: Color(0xECF0F3),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      userData.photo,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              userData.name,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              userData.occupation,
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
