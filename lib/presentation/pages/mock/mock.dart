import 'package:flutter/material.dart';

import '../pages.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  List<bool> bottomNavigationItemStatus = [true, false, false, false];

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
          currentWidgetView = HomePage();
          break;
        case 1:
          currentWidgetView = MyIndications();
          break;
        case 2:
          currentWidgetView = MyNeedRequestPage();
          break;
        case 3:
          currentWidgetView = NeedRequestPage();
          break;
      }

      bottomNavigationItemStatus = [
        index == 0,
        index == 1,
        index == 2,
        index == 3
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: MainDrawer(),
      ),
      backgroundColor: Colors.blueGrey[50],
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
                      icon_name: Icons.home_outlined,
                      text: "Inicial",
                      selected: bottomNavigationItemStatus[0],
                      onPress: () {
                        setCurrentWidgetView(0);
                      },
                    ),
                    BottomNavigationItem(
                      icon_name: Icons.event_available_outlined,
                      text: "Minhas indicações",
                      selected: bottomNavigationItemStatus[1],
                      onPress: () {
                        setCurrentWidgetView(1);
                      },
                    ),
                    BottomNavigationItem(
                      icon_name: Icons.event_note_outlined,
                      text: "Meus pedidos",
                      selected: bottomNavigationItemStatus[2],
                      onPress: () {
                        setCurrentWidgetView(2);
                      },
                    ),
                    BottomNavigationItem(
                      icon_name: Icons.new_releases_outlined,
                      text: "Solicitações rede",
                      selected: bottomNavigationItemStatus[3],
                      onPress: () {
                        setCurrentWidgetView(3);
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
  final IconData icon_name;
  final String text;
  final bool selected;
  final Function onPress;

  BottomNavigationItem({
    @required this.icon_name,
    @required this.text,
    @required this.selected,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    Color kPrimaryColor = Color(0xFF111F5C);
    Color kSecondaryColor = Color(0xFF139AD6);
    Color kGreyColor = Color(0xFF888888);
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Icon(
              icon_name,
              color: selected ? kPrimaryColor : Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selected ? kPrimaryColor : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
