import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repository/repositories.dart';

class MakeIndicationPage extends StatefulWidget {
  final String requestId;

  MakeIndicationPage({Key key, this.requestId}) : super(key: key);

  @override
  _MakeIndicationPageState createState() => _MakeIndicationPageState();
}

class _MakeIndicationPageState extends State<MakeIndicationPage> {
  String knowledgeLevel = 'Conheço muito bem, já usei os serviços.';

  void getKnowledgeLevel(String knowledge) {
    knowledgeLevel = knowledge;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    var friendsList = Provider.of<MyContactSelection>(context).selectedId;
    var photoList = Provider.of<MyContactSelection>(context).selectedPhoto;
    var name = Provider.of<MyContactSelection>(context).selectedName;

    var comments;
    DateTime creationDate = DateTime.now();
    var requestId = widget.requestId;

    print('Lista de Contatos: $friendsList[0]');
    print('Lista de Fotos: $photoList[0]');
    print(knowledgeLevel);
    print(widget.requestId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Indicar Alguém'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10.0),
          color: Colors.lime[100],
          child: Column(
            children: <Widget>[
              Text('Make new Indication'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Indicado',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'oneContact_widget'),
                        icon: Icon(Icons.add),
                        label: Text(''),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  // Photo
                  indicadoAvatar(photoList, name),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              RadioGroup(knowledgeLevel, getKnowledgeLevel),
              SizedBox(
                height: 28,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Comentário'),
                  TextField(
                    maxLines: 2,
                    onChanged: (val) {
                      comments = val;
                    },
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ElevatedButton(
                    child: new Text(
                      'Indicar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      var newIndication = Indication(
                        indicationDate: creationDate,
                        userId: user.uid,
                        requestId: requestId,
                        personIndicatedId: friendsList[0],
                        personIndicatedName: name,
                        personIndicatedPhoto: photoList[0],
                        knowledgeLevel: knowledgeLevel,
                        comments: comments,
                      );
                      print('to aqui');
                      _showCupertinoDialog(context, newIndication, requestId);
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
                      Provider.of<MyContactSelection>(context, listen: false)
                          .clearContactSelection(),
                      Navigator.pop(context),
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget indicadoAvatar(List photoList, String name) {
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

_showCupertinoDialog(
    BuildContext context, Indication newIndication, String requestId) {
  print('Entrei no dialog');
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continuar"),
    onPressed: () {
      Navigator.pop(context);
      _addIndicationToFirestore(newIndication, requestId);
      Provider.of<MyContactSelection>(context, listen: false)
          .clearContactSelection();
      Navigator.pushNamed(context, 'home_screen');
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmação"),
    content: Text("Deseja prosseguir com a indicação?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

_addIndicationToFirestore(Indication newIndication, String requestId) async {
  IndicationRepository indicationRepo = IndicationRepository(requestId);
  try {
    var result = await indicationRepo.addIndication(newIndication.toMap());
    //await needRequestProvider.addRequest(newRequest);

    print(result);
  } catch (e) {
    print(e);
  }
}

class RadioGroup extends StatefulWidget {
  String knowledgeLevel;
  Function getRadioText;

  RadioGroup(this.knowledgeLevel, this.getRadioText);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  // Default Radio Button Selected Item When App Starts.

  // Group Value for Radio Button.
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10.0),
            child:
                Text('Nível de Conhecimento', style: TextStyle(fontSize: 16))),
        Row(
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  widget.knowledgeLevel =
                      'Conheço muito bem, já usei os serviços.';
                  id = 1;
                  widget.getRadioText(widget.knowledgeLevel);
                });
              },
            ),
            Text(
              'Conheço muito bem, já usei os serviços.',
              style: new TextStyle(fontSize: 14.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  widget.knowledgeLevel = 'Conheço, mas nunca usei os serviços';
                  id = 2;
                  widget.getRadioText(widget.knowledgeLevel);
                });
              },
            ),
            Text(
              'Conheço, mas nunca usei os serviços',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 3,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  widget.knowledgeLevel =
                      'Não conheço, mas tenho boas referências';
                  id = 3;
                  widget.getRadioText(widget.knowledgeLevel);
                });
              },
            ),
            Text(
              'Não conheço, mas tenho boas referências',
              style: new TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ],
    );
    ;
  }
}
