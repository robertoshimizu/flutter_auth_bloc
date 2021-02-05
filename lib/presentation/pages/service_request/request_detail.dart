import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:intl/intl.dart';

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
    print(request.requestId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
        actions: <Widget>[
          IconButton(
            iconSize: 25,
            icon: Icon(Icons.delete_forever),
            onPressed: null,
          ),
          IconButton(
            iconSize: 25,
            icon: Icon(Icons.edit),
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
                      labelText: 'Tipo de serviço',
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MakeIndicationPage(
                    //       requestId: request.requestId,
                    //     ),
                    //   ),
                    // );
                  }),
              new ElevatedButton(
                child: new Text(
                  'Ver Indicações',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DisplayIndications(
                  //       requestId: request.requestId,
                  //     ),
                  //   ),
                  // );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
