import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'carrousel_splash.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _totalPages = 4;
  int _currentPage = 0;

  List<Widget> _buildPageIndicator(int pageNum) {
    var color = getPageItems()[pageNum];
    List<Widget> list = [];
    for (var i = 0; i < _totalPages; i++) {
      list.add(i == _currentPage
          ? _indicator(
              true,
              color.buttomColor,
            )
          : _indicator(
              false,
              color.buttomColor,
            ));
    }
    return list;
  }

  Widget _indicator(bool isActive, Color color) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: 6.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: getPageItems()
                        .map((item) => renderPageItem(item))
                        .toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(_currentPage),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              startButtons(_currentPage),
              // Text('This is a Splash Screen.button to start a session'),
              // Text('it should have a carrousel'),
              // Text('Button to register or login a user'),
            ],
          ),
        ),
      ),
    );
  }

  Widget startButtons(int pageNum) {
    var color = getPageItems()[pageNum];
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 55, // Will take 50% of screen space
            decoration: BoxDecoration(
                color: color.buttomColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (color.buttomColor).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  )
                ]),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(Login());
                // Navigator.pushNamed(context, 'phoneLoginWrapper');
              },
              child: Center(
                child: Text(
                  'Pular'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column renderPageItem(PageItem item) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 38.0,
          ),
          child: Center(
            child: Image(
              image: AssetImage(item.imageUrl),
              height: size.height * 0.16,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            child: Text(
              (item.title).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 54.0),
          child: Text(
            (item.description),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
      ],
    );
  }
}
