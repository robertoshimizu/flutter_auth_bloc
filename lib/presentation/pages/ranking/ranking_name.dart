import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';

import '../../../locator.dart';

class RankingNamePage extends StatelessWidget {
  RankingNamePage({Key key}) : super(key: key);

  final DataUserRepository qquer = locator<DataUserRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: qquer.fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserData> requests = snapshot.data;
          return new ListView.builder(
            itemCount: requests.length,
            itemBuilder: (buildContext, index) => Card(
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
                        image: NetworkImage(requests[index].photo),
                      ),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              requests[index].name,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),

                            // Title
                            Text(
                              requests[index].occupation,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            // Description
                            Text(
                              requests[index].companyName,
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
          );
        } else if (snapshot.hasError) {
          return Text("No users found");
        } else
          return LoadingIndicator();
      },
    );
  }
}
