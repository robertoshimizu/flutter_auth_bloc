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

              // height: MediaQuery.of(context).size.height * 0.45,
              // width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Color(0xffEE6B12),
                      width: .5,
                    ),
                  ),
                  elevation: 4,
                  child: Container(
                    child: Row(
                      children: [
                        // Photo
                        SizedBox(
                          height: 90,
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(photo),
                          ),
                        ),

                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '$name precisa de ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),

                                // Title
                                Text(
                                  requestDetails.serviceClassification,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                // Description
                                Text(
                                  requestDetails.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
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
