import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/service_request/requests_card.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class MyNeedRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // AllRequests allRequests = AllRequests();
    List<NeedRequest> requests;
    final needRequestProvider = Provider.of<DataAllRequests>(context);
    final AuthRepository _authRepository = locator<DataAuthRepository>();
    AppUser _user = _authRepository.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Solicitações de Indicações'),
      ),
      // drawer: Container(
      //   width: MediaQuery.of(context).size.width * 0.9,
      //   child: MainDrawer(),
      // ),
      body: Container(
        child: StreamBuilder(
            stream: needRequestProvider.fetchMyRequestsAsStream(_user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print('stream de needRequests tem data');
                requests = snapshot.data;
                return new ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (buildContext, index) =>
                      RequestCard(requestDetails: requests[index]),
                  // children:
                  //     snapshot.data.documents.map((DocumentSnapshot document) {
                  //   return new ListTile(
                  //     title: new Text(document['description']),
                  //     subtitle: new Text(document['serviceClassification']),
                  //   );
                  // }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'error',
                  style: TextStyle(fontSize: 20.0),
                );
              } else {
                print('modo wait');
                return Text('Não há nenhuma requisição na plataforma');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          'addRequest_screen',
        ),
        tooltip: 'Add New Request',
        child: Icon(Icons.add),
      ),
    );
  }
}