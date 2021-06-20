import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import '../../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages.dart';

class Master extends StatelessWidget {
  final UserData user;
  Master({
    Key key,
    @required this.user,
  }) : super(key: key);

  final List<bool> bottomNavigationItemStatus = [
    false,
    true,
    false,
    false,
    false,
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PagesBloc(),
      child: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leadingWidth: 0.0,
            centerTitle: false,
            title: Image.asset(
              'assets/icons/logo-eu-indico.png',
            ),
            actions: [
              GestureDetector(
                child: Image.asset(
                  'assets/icons/menu-bar.png',
                ),
                onTap: () => _openDrawer(),
              ),
            ],
          ),
          drawer: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MainDrawer(),
          ),
          backgroundColor: Colors.white,
          body: MasterBody(user: user),
          bottomNavigationBar: MasterNavigationBar(
              bottomNavigationItemStatus: bottomNavigationItemStatus),
        ),
      ),
    );
  }
}

class MasterBody extends StatelessWidget {
  const MasterBody({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagesBloc, PagesState>(
      builder: (context, state) {
        if (state is PagesOne) {
          return NeedRequestPage();
        } else if (state is PagesTwo) {
          return MyIndications();
        } else if (state is PagesThree) {
          return MyProfile(
            user: user,
          );
        } else if (state is PagesFour) {
          return MyNeedRequestPage();
        } else if (state is PagesFive) {
          return RankingMainPage();
        } else
          return HomePage();
      },
    );
  }
}

class MasterNavigationBar extends StatelessWidget {
  const MasterNavigationBar({
    Key key,
    @required this.bottomNavigationItemStatus,
  }) : super(key: key);

  final List<bool> bottomNavigationItemStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagesBloc, PagesState>(
      builder: (context, state) {
        return Container(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavigationItem(
                color: Color(0xff71196F),
                text: "pedidos",
                selected: bottomNavigationItemStatus[0],
                onPress: () {
                  BlocProvider.of<PagesBloc>(context).add(PagesEvent.one);
                },
              ),
              BottomNavigationItem(
                color: Color(0xff84BC75),
                text: "fiz indicação",
                selected: bottomNavigationItemStatus[1],
                onPress: () {
                  BlocProvider.of<PagesBloc>(context).add(PagesEvent.two);
                },
              ),
              BottomNavigationItem(
                color: Color(0xffD61C80),
                text: "Meu perfil",
                selected: bottomNavigationItemStatus[2],
                onPress: () {
                  BlocProvider.of<PagesBloc>(context).add(PagesEvent.three);
                },
              ),
              BottomNavigationItem(
                color: Color(0xff008FCA),
                text: "pedi indicação",
                selected: bottomNavigationItemStatus[3],
                onPress: () {
                  BlocProvider.of<PagesBloc>(context).add(PagesEvent.four);
                },
              ),
              BottomNavigationItem(
                color: Color(0xffEE6B12),
                text: "ranking",
                selected: bottomNavigationItemStatus[4],
                onPress: () {
                  BlocProvider.of<PagesBloc>(context).add(PagesEvent.five);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool selected;
  final Function onPress;

  BottomNavigationItem({
    @required this.color,
    @required this.text,
    @required this.selected,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    bool doubleChar = text.contains(" ");

    if (text == "meu perfil") {
      doubleChar = false;
    }
    return selected
        ? GestureDetector(
            onTap: () {
              onPress();
            },
            child: Container(
              height: 12,
              width: 80,
              child: Stack(
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top: -10,
                    child: Container(
                      width: 58.0,
                      height: 58.0,
                      decoration: new BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    child: Container(
                      width: 53,
                      height: 58,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              text.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              onPress();
            },
            child: Container(
              height: 12,
              width: 80,
              child: Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    bottom: -14,
                    // Container somente para provocar wrap no titulo
                    child: Container(
                      width: 48,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              text.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 28,
                    child: Container(
                      width: 58.0,
                      height: 58.0,
                      decoration: new BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
