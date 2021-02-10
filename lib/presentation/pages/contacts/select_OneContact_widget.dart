import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/repository/userFriends_repository.dart';
import 'package:provider/provider.dart';

class SelectOneContact extends StatefulWidget {
  @override
  _SelectOneContactState createState() => _SelectOneContactState();
}

class _SelectOneContactState extends State<SelectOneContact> {
  bool isChecked = false;

  void eraseAllBoxesCallback() {
    setState(() {
      isChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    MyContacts myContacts = MyContacts(userId: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione Um Contato'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: myContacts.userFriendsCollection(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    var checkBoxController;
                    var id =
                        Provider.of<MyContactSelection>(context).selectedId;
                    if (id.isNotEmpty) {
                      checkBoxController = id[0];
                    } else {
                      checkBoxController = '';
                    }
                    return new ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(document.data()['photo']),
                      ),
                      title: new Text(document.data()['name']),
                      subtitle: new Text(document.data()['type']),
                      trailing: ContactoCheckBox(
                        document_id: document.data()['_id'].toString(),
                        document_name: document.data()['name'].toString(),
                        document_photo: document.data()['photo'].toString(),
                        checkboxState: (checkBoxController ==
                                document.data()['_id'].toString())
                            ? true
                            : isChecked,
                        changeCheckBoxState: eraseAllBoxesCallback,
                      ),
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
                  heightFactor: 10,
                  child: new Text(
                    'Sua Lista de Contatos está vazia',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

class ContactoCheckBox extends StatefulWidget {
  final String document_id;
  final String document_name;
  final String document_photo;
  bool checkboxState;
  final Function changeCheckBoxState;

  ContactoCheckBox(
      {this.document_id,
      this.document_name,
      this.document_photo,
      this.checkboxState,
      this.changeCheckBoxState});

  @override
  _ContactCheckBoxState createState() => _ContactCheckBoxState();
}

class _ContactCheckBoxState extends State<ContactoCheckBox> {
  @override
  Widget build(BuildContext context) {
    var id = Provider.of<MyContactSelection>(context).selectedId;
    return Checkbox(
        value: widget.checkboxState,
        onChanged: (newValue) {
          if (id.isEmpty) {
            print(widget.document_id);
            setState(() {
              widget.checkboxState = newValue;
            });
            Provider.of<MyContactSelection>(context, listen: false)
                .selectOneContact(widget.document_id, widget.document_name,
                    widget.document_photo);
          } else {
            if (id[0] == widget.document_id) {
              setState(() {
                widget.checkboxState = false;
              });
              Provider.of<MyContactSelection>(context, listen: false)
                  .selectOneContact(widget.document_id, widget.document_name,
                      widget.document_photo);
            } else {
              Provider.of<MyContactSelection>(context, listen: false)
                  .clearContactSelection();

              setState(() {
                widget.checkboxState = true;
              });
              widget.changeCheckBoxState();
              Provider.of<MyContactSelection>(context, listen: false)
                  .selectOneContact(widget.document_id, widget.document_name,
                      widget.document_photo);
            }
          }
        });
  }
}
