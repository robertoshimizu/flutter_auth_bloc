import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/repository/userFriends_repository.dart';
import 'package:provider/provider.dart';

class SelectContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    MyContacts myContacts = MyContacts(userId: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione os Contatos'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: myContacts.userFriendsCollection(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                // var lista =
                //     snapshot.data.documents.map((e) => e['_id']).toList();
                // print(lista);
                // print(_selectedList);
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    // print(_selectedList);
                    return new ListTile(
                      selected: false,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(document.data()['photo']),
                      ),
                      title: new Text(document.data()['name']),
                      subtitle: new Text(document.data()['type']),
                      trailing: ContactCheckBox(
                          document_id: document.data()['_id'].toString(),
                          document_photo: document.data()['photo'].toString()),
                      onTap: null,
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

class ContactCheckBox extends StatefulWidget {
  final String document_id;
  final String document_photo;
  const ContactCheckBox(
      {Key key, @required this.document_id, this.document_photo})
      : super(key: key);

  @override
  _ContactCheckBoxState createState() => _ContactCheckBoxState(
      document_id: this.document_id, document_photo: this.document_photo);
}

class _ContactCheckBoxState extends State<ContactCheckBox> {
  String document_id;
  String document_photo;

  bool isChecked = false;
  _ContactCheckBoxState({this.document_id, this.document_photo});

  @override
  Widget build(BuildContext context) {
    //print(widget.document_id);
    return Checkbox(
      value: isChecked,
      onChanged: (newValue) {
        print(widget.document_id);
        Provider.of<MyContactSelection>(context, listen: false)
            .selectContacts(widget.document_id, widget.document_photo);
        setState(() {
          isChecked = newValue;
        });
      },
    );
  }
}
