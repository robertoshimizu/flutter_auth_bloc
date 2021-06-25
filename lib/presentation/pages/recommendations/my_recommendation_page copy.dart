import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import '../pages.dart';

class MyIndications extends StatelessWidget {
  MyIndications({
    Key key,
  }) : super(key: key);

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser _user = _authRepository.user;
    MyIndicationRepository myindicationrep = MyIndicationRepository();
    final needRequestProvider = Provider.of<DataAllRequests>(context);
    final qqeur = Provider.of<DataUserRepository>(context);
    List<Indication> indications;

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
            'meus indicados'.toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: FutureBuilder<List<Indication>>(
              future: myindicationrep.fetchMyIndications(_user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  indications = snapshot.data.toList();
                  // indications.forEach((element) {
                  //   print(element.personIndicatedName);
                  // });
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 10 / 5,
                      children: new List.generate(
                        indications.length,
                        (index) => SizedBox(
                          height: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                width: .1,
                              ),
                            ),
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Photo
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(indications[index]
                                        .personIndicatedPhoto),
                                    height: double.infinity,
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      indications[index].personIndicatedName,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
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
                      ),
                    ],
                  ));
                }
              }),
        ),
      ],
    );
  }
}
