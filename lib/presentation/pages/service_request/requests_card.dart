import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/presentation/pages/service_request/request_detail.dart';
import 'package:provider/provider.dart';

class RequestCard extends StatelessWidget {
  final NeedRequest requestDetails;
  RequestCard({@required this.requestDetails});

  @override
  Widget build(BuildContext context) {
    final qqeur = Provider.of<DataUserRepository>(context);
    var uid = requestDetails.userId;

    return FutureBuilder(
        future: qqeur.getUserById(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var name = snapshot.data["name"];
            var photo = snapshot.data["photo"];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestDetails(
                      request: requestDetails,
                      name: name,
                      photo: photo,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                  elevation: 5,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Title
                              Text(
                                requestDetails.serviceClassification,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              // Description
                              Text(
                                requestDetails.serviceClassification,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // Photo
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(photo),
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
                            ],
                          ),
                        )
                      ],
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
                  )
                ],
              ),
            );
          }
        });
  }
}
