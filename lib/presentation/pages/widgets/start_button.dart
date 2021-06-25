import 'package:flutter/material.dart';

Widget startButtons(
    Color color, String buttomText, BuildContext context, Function onTapFunc) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          height: 55, // Will take 50% of screen space
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: (color).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                )
              ]),
          child: GestureDetector(
            onTap: onTapFunc,
            child: Center(
              child: Text(
                buttomText.toUpperCase(),
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
