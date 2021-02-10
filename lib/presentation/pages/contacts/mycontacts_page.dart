import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/repository/userFriends_repository.dart';

class Contacts extends StatelessWidget {
  final String userId;

  const Contacts(this.userId);
  @override
  Widget build(BuildContext context) {
    MyContacts myContacts = MyContacts(userId: userId);

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
