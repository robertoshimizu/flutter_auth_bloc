import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class MyIndications extends StatelessWidget {
  MyIndications({
    Key key,
  }) : super(key: key);

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser _user = _authRepository.user;
    MyIndicationRepository myindicationrep = MyIndicationRepository();
    List<Indication> indications;
    final qqeur = Provider.of<DataUserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Indicações'),
      ),
      body: Container(
        color: Colors.amber.shade100,
        child: StreamBuilder<QuerySnapshot>(
            stream: myindicationrep.fetchMyIndicationAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                // indications = snapshot.data.docs
                //     .map((doc) => Indication.fromMap(doc.data(), doc.id))
                //     .toList();
                return new Text('OI');
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
