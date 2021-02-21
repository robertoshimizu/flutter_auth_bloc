import 'package:flutter/material.dart';

class IndicadoAvatar extends StatelessWidget {
  final List photoList;
  final String name;

  IndicadoAvatar(this.photoList, this.name);

  @override
  Widget build(BuildContext context) {
    if (photoList.isNotEmpty) {
      return Container(
          child: Row(
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(photoList[0]),
            ),
          ),
          Text(name),
        ],
      ));
    } else
      return Container(
        child: Text(''),
      );
  }
}
