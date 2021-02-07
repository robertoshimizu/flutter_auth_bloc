import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'take_picture_screen.dart';

class FirstProfile3 extends StatefulWidget {
  @override
  _FirstProfile3State createState() => _FirstProfile3State();
}

class _FirstProfile3State extends State<FirstProfile3> {
  @override
  Widget build(BuildContext context) {
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
                'Tire uma selfie',
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
                  'Precisamos de uma foto sua (selfie) só pra registrar e autorizar a criação da sua conta.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage('assets/images/Component 33.png'),
                  ),
                  Image(
                    image: AssetImage('assets/images/Component 34.png'),
                  ),
                  Image(
                    image: AssetImage('assets/images/Component 35.png'),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width * 0.85,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TakePictureScreen()));
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
    );
  }
}
