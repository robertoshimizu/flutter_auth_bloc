import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';

import 'package:flutter_auth_bloc/locator.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';
import '../pages.dart';

class RequestDetails extends StatelessWidget {
  final NeedRequest request;
  final String name;
  final String photo;

  RequestDetails({
    @required this.request,
    @required this.name,
    @required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    //final indicationProvider = Provider.of<IndicationRepository>(context);
    print('ID da solictação: ${request.requestId}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Solicitação'),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            iconSize: 25,
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            onPressed: () {
              _showCupertinoDialog(context, request.requestId);
            },
          ),
          IconButton(
            iconSize: 25,
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Form(
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
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Tipo de indicação',
                    ),
                    controller: TextEditingController(
                      text: request.serviceClassification,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    maxLines: 8,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                    controller: TextEditingController(
                      text: request.description,
                    ),
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
                                .format(request.creationDate),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Data de expiração',
                          ),
                          controller: TextEditingController(
                            text: DateFormat('dd-MM-yyyy')
                                .format(request.expiringDate),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '# Indicações:    ${request.indications.length.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      // Photo
                      Text(
                        '# Aplicações:    ${request.applications.length.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                    'Fazer uma indicação',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakeIndicationPage(
                          requestId: request.requestId,
                        ),
                      ),
                    );
                  }),
              new ElevatedButton(
                child: new Text(
                  'Ver Indicações',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayIndications(
                        requestId: request.requestId,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  _showCupertinoDialog(BuildContext context, String requestId) {
    print('Alert para confirmação deletar requestId: $requestId');
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
        // Navigator.pop(context);
        // _addIndicationToFirestore(newIndication, requestId);
        _deleteRequestFromFirestore(requestId);
        Navigator.pushNamedAndRemoveUntil(context, 'home_screen', (_) => false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmação"),
      content: Text("Deseja mesmo deletar a sua solicitação de indicação?"),
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

  _deleteRequestFromFirestore(String requestId) {
    var qquer = locator<DataAllRequests>();
    try {
      qquer.deleteRequest(requestId);

      print("RequestId $requestId deleted!");
    } catch (e) {
      print(e);
    }
  }
}
