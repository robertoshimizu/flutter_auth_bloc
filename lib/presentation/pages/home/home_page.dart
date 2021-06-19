import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            return Master(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 12.0, right: 12.0, bottom: 12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StarRanking(
                      rating: 2.7,
                      size: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'ranking'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          '95',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Color(0xffFFFFFF),
                    width: .3,
                  ),
                ),
                elevation: 2,
                child: Row(
                  children: [
                    // Photo
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(user.photo),
                        height: 180,
                      ),
                    ),

                    Flexible(
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ),

                            // Title
                            Text(
                              user.occupation,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                  '44',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'indicações feitas'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                  '12',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'indicações recebidas'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Indicado por Júlio Macedo Valério e mais 5 pessoas',
                              style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'especialidades'.toUpperCase(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.about),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Membro desde ${DateFormat.yM('pt_BR').format(user.registered)}'),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        new ColoredRoundedButton(
          text: 'PAINEL DE SOLICITAÇÕES',
          onPress: () {
            BlocProvider.of<PagesBloc>(context).add(PagesEvent.one);
          },
          enabled: true,
          color: Color(0xff71196F),
        ),
        new ColoredRoundedButton(
          text: 'INDICAÇÕES QUE EU PEDI',
          onPress: () {
            BlocProvider.of<PagesBloc>(context).add(PagesEvent.four);
          },
          enabled: true,
          color: Color(0xff84BC75),
        ),
        new ColoredRoundedButton(
          text: 'INDICAÇÕES QUE EU FIZ',
          onPress: () {
            BlocProvider.of<PagesBloc>(context).add(PagesEvent.two);
          },
          enabled: true,
          color: Color(0xff008FCA),
        ),
        new ColoredRoundedButton(
          text: 'RANKING DE INDICADOS',
          onPress: () {
            BlocProvider.of<PagesBloc>(context).add(PagesEvent.five);
          },
          enabled: true,
          color: Color(0xffEE6B12),
        ),
      ],
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
