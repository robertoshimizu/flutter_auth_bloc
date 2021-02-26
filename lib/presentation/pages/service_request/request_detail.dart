import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import 'package:flutter_auth_bloc/locator.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';
import '../pages.dart';

class RequestDetails extends StatefulWidget {
  final NeedRequest request;
  final String name;
  final String photo;

  RequestDetails({
    @required this.request,
    @required this.name,
    @required this.photo,
  });

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final AuthRepository _authRepository = locator<DataAuthRepository>();
  final AllRequests qqeur = locator<DataAllRequests>();
  final formKey = GlobalKey<FormState>();
  int index = 0;

  List<Map<dynamic, dynamic>> _categories = [
    {
      'menu': 'Editar',
      'icon': Icons.edit,
      'enabled': false,
    },
    {
      'menu': 'Salvar',
      'icon': Icons.save,
      'enabled': true,
    },
  ];
  // form values

  @override
  Widget build(BuildContext context) {
    AppUser _user = _authRepository.user;
    //final indicationProvider = Provider.of<IndicationRepository>(context);
    // print('ID da solictação: ${request.requestId}');
    // print('UserId do solicitante ${request.userId}');
    // print('UserId do usuário logado ${_user.uid}');
    bool sameUser = widget.request.userId == _user.uid ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Solicitação'),
        actions: <Widget>[
          DeleteButton(widget.request.requestId, sameUser),
          (sameUser == true)
              ? IconButton(
                  iconSize: 25,
                  icon: Icon(
                    _categories[index]['icon'],
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (index == 0) {
                      setState(() {
                        index = 1;
                      });
                    } else if (index == 1) {
                      setState(() {
                        index = 0;
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          print(widget.request.requestId);
                          qqeur.updateRequest(widget.request);
                        }
                      });
                    }
                  },
                )
              : SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
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
                          backgroundImage: NetworkImage(widget.photo),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        // UserName
                        Text(
                          widget.name,
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
                      enabled: _categories[index]['enabled'],
                      decoration: InputDecoration(
                        labelText: 'Indicação',
                      ),
                      initialValue: widget.request.serviceClassification,
                      onChanged: (value) => setState(
                        () => widget.request.serviceClassification = value,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      maxLines: 8,
                      enabled: _categories[index]['enabled'],
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                      ),
                      initialValue: widget.request.description,
                      onChanged: (value) => setState(
                        () => widget.request.description = value,
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
                                  .format(widget.request.creationDate),
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
                                  .format(widget.request.expiringDate),
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
                          '# Indicações:    ${widget.request.indications.length.toString()}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // Photo
                        Text(
                          '# Aplicações:    ${widget.request.applications.length.toString()}',
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
                            requestId: widget.request.requestId,
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
                          requestId: widget.request.requestId,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final String requestId;
  final bool visible;

  DeleteButton(this.requestId, this.visible);

  @override
  Widget build(BuildContext context) {
    if (visible == true) {
      return IconButton(
        color: Colors.white,
        iconSize: 25,
        icon: Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
        onPressed: () {
          _showCupertinoDialog(context, requestId);
        },
      );
    } else
      return SizedBox();
  }
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
