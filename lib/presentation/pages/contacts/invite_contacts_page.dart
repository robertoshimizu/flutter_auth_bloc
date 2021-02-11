import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteNewFriends extends StatelessWidget {
  final String invitation =
      'Eu%20queria%20te%20convidar%20para%20se%20conectar%20comigo%20no%20EuIndico.app';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Convidar amigos',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          color: Color(0xFF353B4E),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 40),
                child: Text(
                  'Convide o pessoal!',
                  style: TextStyle(
                    color: Color(0xff00B878),
                    fontSize: 26,
                  ),
                ),
              ),
              MenuCard(
                name: 'WhatsApp',
                url: "whatsapp://wa.me/?text=$invitation",
              ),
              MenuCard(
                name: 'Facebook Messenger',
              ),
              MenuCard(
                name: 'E-mail',
              ),
              MenuCard(
                name: 'Outros',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String name;
  final String url;
  const MenuCard({
    Key key,
    this.name,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      ),
    );
  }
}
