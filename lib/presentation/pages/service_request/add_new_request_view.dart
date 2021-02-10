import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repository/contactSelection_repository.dart';
import '../../../locator.dart';

class AddNewRequestPage extends StatefulWidget {
  @override
  _AddNewRequestPageState createState() => _AddNewRequestPageState();
}

class _AddNewRequestPageState extends State<AddNewRequestPage> {
  final _formKey = GlobalKey<FormState>();
  var photoList;
  var friendsList;

  // text field state
  String description = '';
  String serviceTitle = '';
  DateTime creationDate = DateTime.now();
  DateTime expiringDate = DateTime(
      DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final qqeur = locator<DataUserRepository>();
    final needRequestProvider = Provider.of<DataAllRequests>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Nova Requisição'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: qqeur.getUserById(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var name = snapshot.data['name'];
                var photo = snapshot.data['photo'];

                friendsList =
                    Provider.of<MyContactSelection>(context).selectedId;
                photoList =
                    Provider.of<MyContactSelection>(context).selectedPhoto;
                print('Lista de Contatos: $friendsList');
                print('Lista de Fotos: $photoList');

                NeedRequest newRequest;
                return Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        color: Colors.yellow[100].withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Solicitante:    ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                // Photo
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(photo),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                // UserName
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(
                                labelText: 'Tipo de serviço',
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Entre com tipo de serviço que vc precisa'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  serviceTitle = val;
                                });
                              },
//                              controller: TextEditingController(
//                                text: '',
//                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            TextFormField(
                              maxLines: 8,
                              enabled: true,
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Descreva com detalhes o que vc está buscando'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  description = val;
                                });
                              },
//                              controller: TextEditingController(
//                                text: '',
//                              ),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: 'Data de criação',
                                    ),
                                    controller: TextEditingController(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(creationDate),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: 'Data de expiração',
                                    ),
                                    controller: TextEditingController(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(expiringDate),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Destinatários',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () => Navigator.pushNamed(
                                          context, 'contacts_widget'),
                                      icon: Icon(Icons.add),
                                      label: Text(''),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  width: 12,
                                ),
                                // Photo

                                listofAvatars(photoList),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ElevatedButton(
                          child: new Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            newRequest = NeedRequest(
                              requestId: '',
                              creationDate: creationDate,
                              expiringDate: expiringDate,
                              userId: user.uid,
                              description: description,
                              destinationFriends: friendsList,
                              serviceClassification: serviceTitle,
                              indications: [],
                              applications: [],
                            );
                            print(newRequest.toString());
                            try {
                              var result = await needRequestProvider
                                  .addRequest(newRequest);

                              print(result);
                            } catch (e) {
                              print(e);
                            }

                            Provider.of<MyContactSelection>(context,
                                    listen: false)
                                .clearContactSelection();
                            Navigator.pop(context);
                          },
                        ),
                        new ElevatedButton(
                          child: new Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => {
                            Provider.of<MyContactSelection>(context,
                                    listen: false)
                                .clearContactSelection(),
                            Navigator.pop(context),
                          },
                        )
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Did not load userData',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
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
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget listofAvatars(List photoList) {
    List<Widget> list = [];
    var range = photoList.length;
    for (var i = 0; i < range; i++) {
      list.add(Container(
          child: FittedBox(
        fit: BoxFit.fitWidth,
        child: CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(photoList[i]),
        ),
      )));
    }
    return Wrap(
        spacing: 5.0, // gap between lines
        children: list);
  }
}
