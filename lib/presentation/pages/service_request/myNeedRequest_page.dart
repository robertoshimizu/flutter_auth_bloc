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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: Text(
              'INDICAÇÕES QUE EU PEDI'.toUpperCase(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: needRequestProvider.fetchMyRequestsAsStream(_user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print('stream de needRequests tem data');
                  requests = snapshot.data;
                  return new ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (buildContext, index) => ListTile(
                      title: Text(
                        requests[index].serviceClassification,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // RequestCard(requestDetails: requests[index]),
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
                  return Text('Não há nenhuma requisição na plataforma');
                }
              },
            ),
          ),
        ],
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
