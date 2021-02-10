import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/userFriends_repository.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    MyContacts myContacts = MyContacts(userId: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Page'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: myContacts.userFriendsCollection(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(document.data()['photo']),
                      ),
                      title: new Text(document.data()['name']),
                      // subtitle: new Text(document['gender']),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'error',
                  style: TextStyle(fontSize: 20.0),
                );
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ));
              }
            }),
      ),
    );
  }
}
