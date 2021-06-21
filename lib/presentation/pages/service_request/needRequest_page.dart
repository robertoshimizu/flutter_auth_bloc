import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/service_request/requests_card.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class NeedRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // AllRequests allRequests = AllRequests();
    List<NeedRequest> requests;
    final needRequestProvider = Provider.of<DataAllRequests>(context);
    final AuthRepository _authRepository = locator<DataAuthRepository>();
    AppUser _user = _authRepository.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Text(
            'pedidos'.toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: StreamBuilder(
            stream: needRequestProvider.fetchRequestsAsStream(_user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print('stream de needRequests tem data');
                requests = snapshot.data;
                return new ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (buildContext, index) =>
                      RequestCard(requestDetails: requests[index]),
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
    );
  }
}
