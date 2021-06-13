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
                            StarRanking(
                              rating: 2.7,
                            ),

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

class StarRanking extends StatelessWidget {
  final double rating;
  const StarRanking({
    Key key,
    @required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating <= 5.0 && rating >= 0) {
      // print(
      //     "rate: $rating, parte inteira: ${rating.toInt()}, parte decimal ${rating.remainder(rating.toInt())}");
      var vetor = [];
      for (var i = 0; i < rating.toInt(); i++) {
        vetor.add(
          Icons.star,
        );
      }
      if (rating.remainder(rating.toInt()) < 0.5 ||
          rating.remainder(rating.toInt()).isNaN) {
        vetor.add(
          Icons.star_outline_outlined,
        );
      } else
        vetor.add(
          Icons.star_half_outlined,
        );
      for (var i = rating.toInt() + 1; i <= 5 - 1; i++) {
        vetor.add(
          Icons.star_outline_outlined,
        );
      }

      return Row(
        children: [
          Icon(
            vetor[0],
            color: Colors.black87,
            size: 12.0,
          ),
          Icon(
            vetor[1],
            color: Colors.black87,
            size: 12.0,
          ),
          Icon(
            vetor[2],
            color: Colors.black87,
            size: 12.0,
          ),
          Icon(
            vetor[3],
            color: Colors.black87,
            size: 12.0,
          ),
          Icon(
            vetor[4],
            color: Colors.black87,
            size: 12.0,
          ),
        ],
      );
    } else
      return SizedBox();
  }
}
