import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final bool enabled;

  RoundedButton({@required this.text, this.onPress, this.enabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 60,
        width: 350,
        decoration: BoxDecoration(
            color: enabled ? Color(0xff00B878) : Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            border: Border.all(
              color: Color(0xff00B878),
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: enabled ? Colors.white : Color(0xff00B878),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredRoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;
  final bool enabled;

  ColoredRoundedButton(
      {@required this.text, this.onPress, this.enabled, @required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 55,
          width: 350,
          decoration: BoxDecoration(
              color: enabled ? color : Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              border: Border.all(
                color: color,
              )),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: enabled ? Colors.white : color,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
