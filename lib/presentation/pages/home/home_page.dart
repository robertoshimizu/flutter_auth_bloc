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
            UserData user = UserData.fromMap(snapshot.data, _user.uid);
            return MyProfile(
              user: user,
            );
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

class MyProfile extends StatelessWidget {
  final UserData user;
  const MyProfile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Usuário Logado: ${user.name}',
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

// class MainMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multi-Styled text'),
//       ),
//       body: Center(
//         child: Container(
//           color: Colors.yellow[50],
//           width: 100,
//           margin: EdgeInsets.all(10),
//           child: createPrivacyPolicyMultiStyledTextWidget(),
//           //child:  createSignUpWiget(),
//         ),
//       ),
//     );
//   }

//   Widget createSignUpWiget() {
//     List<StyleModel> styledText = [
//       StyleModel(text: 'Don’t have an account?'),
//       StyleModel(
//           text: 'Sign Up',
//           hasAction: true,
//           style: TextStyle(
//               fontSize: 18,
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w700))
//     ];
//     return createMultiStyledTextWidget(styledText);
//   }

//   Widget createPrivacyPolicyMultiStyledTextWidget() {
//     List<StyleModel> styledText = [
//       StyleModel(text: 'I accept'),
//       StyleModel(
//           text: 'Terms of Service',
//           hasAction: true,
//           style: TextStyle(
//               fontSize: 18,
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w700)),
//       StyleModel(text: 'and'),
//       StyleModel(
//           text: 'Privacy Policy.',
//           hasAction: true,
//           style: TextStyle(
//               fontSize: 18,
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w700)),
//     ];
//     return createMultiStyledTextWidget(styledText);
//   }

//   Wrap createMultiStyledTextWidget(List<StyleModel> modelList) {
//     List<Widget> wrapWidgets = [];
//     for (StyleModel model in modelList) {
//       wrapWidgets.add(getTextWidget(styleModel: model));
//     }
//     return Wrap(
//       spacing: 3.0,
//       direction: Axis.horizontal,
//       alignment: WrapAlignment.start,
//       children: wrapWidgets,
//     );
//   }

//   Widget getTextWidget({@required StyleModel styleModel}) {
//     if (styleModel.hasAction) {
//       return InkWell(
//         onTap: () {
//           print('Actions:- ${styleModel.text}');
//         },
//         child: Text(styleModel.text, style: styleModel.style),
//       );
//     } else {
//       return Text(styleModel.text, style: styleModel.style);
//     }
//   }
// }

// class StyleModel {
//   StyleModel(
//       {@required this.text,
//       this.style = const TextStyle(fontSize: 18),
//       this.hasAction = false});
//   final String text;
//   final TextStyle style;
//   final bool hasAction;
// }
