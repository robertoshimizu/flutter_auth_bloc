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
          requests.sort((a, b) => (a.name).compareTo(b.name));
          return new ListView.builder(
            itemCount: requests.length,
            itemBuilder: (buildContext, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Color(0xffFFFFFF),
                  width: .3,
                ),
              ),
              elevation: 2,
              child: Row(
                children: [
                  // Photo
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image(
                      fit: BoxFit.none,
                      image: NetworkImage(requests[index].photo),
                      height: 80,
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
                            size: 12.0,
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
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          // Description
                          Text(
                            'Indicado por Júlio Macedo Valério e mais 5 pessoas',
                            style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            softWrap: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    '6',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'indicações'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    'ranking'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    '95',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
  final double size;
  const StarRanking({
    Key key,
    @required this.rating,
    @required this.size,
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
            size: size,
          ),
          Icon(
            vetor[1],
            color: Colors.black87,
            size: size,
          ),
          Icon(
            vetor[2],
            color: Colors.black87,
            size: size,
          ),
          Icon(
            vetor[3],
            color: Colors.black87,
            size: size,
          ),
          Icon(
            vetor[4],
            color: Colors.black87,
            size: size,
          ),
        ],
      );
    } else
      return SizedBox();
  }
}
