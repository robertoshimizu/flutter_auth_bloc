import 'package:flutter/material.dart';

import '../pages.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  List<bool> bottomNavigationItemStatus = [true, false, false, false, false];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  Widget currentWidgetView;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentWidgetView = HomePage();
    });
  }

  setCurrentWidgetView(int index) {
    setState(() {
      switch (index) {
        case 0:
          currentWidgetView = NeedRequestPage();
          break;
        case 1:
          currentWidgetView = MyIndications();
          break;
        case 2:
          currentWidgetView = HomePage();
          break;
        case 3:
          currentWidgetView = MyNeedRequestPage();
          break;
        case 4:
          currentWidgetView = RankingMainPage();
          break;
      }

      bottomNavigationItemStatus = [
        index == 0,
        index == 1,
        index == 2,
        index == 3,
        index == 4
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: currentWidgetView,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          color: Colors.blueGrey[50],
          child: Column(
            children: [
              Container(
                height: 2,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomNavigationItem(
                      color: Color(0xff71196F),
                      text: "pedidos",
                      selected: bottomNavigationItemStatus[0],
                      onPress: () {
                        setCurrentWidgetView(0);
                      },
                    ),
                    BottomNavigationItem(
                      color: Color(0xff84BC75),
                      text: "fiz indicação",
                      selected: bottomNavigationItemStatus[1],
                      onPress: () {
                        setCurrentWidgetView(1);
                      },
                    ),
                    BottomNavigationItem(
                      color: Color(0xffD61C80),
                      text: "Meu perfil",
                      selected: bottomNavigationItemStatus[2],
                      onPress: () {
                        setCurrentWidgetView(2);
                      },
                    ),
                    BottomNavigationItem(
                      color: Color(0xff008FCA),
                      text: "pedi indicação",
                      selected: bottomNavigationItemStatus[3],
                      onPress: () {
                        setCurrentWidgetView(3);
                      },
                    ),
                    BottomNavigationItem(
                      color: Color(0xffEE6B12),
                      text: "ranking",
                      selected: bottomNavigationItemStatus[4],
                      onPress: () {
                        setCurrentWidgetView(4);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
    Color kPrimaryColor = Color(0xFF111F5C);
    bool doubleChar = text.contains(" ");

    if (text == "meu perfil") {
      doubleChar = false;
    }
    print(doubleChar);
    return selected
        ? GestureDetector(
            onTap: () {
              onPress();
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 55,
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
                  top: (doubleChar) ? 23 : 30,
                  left: 6,
                )
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              onPress();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 24,
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
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
  }
}
