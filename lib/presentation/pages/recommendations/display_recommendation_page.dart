import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:provider/provider.dart';

class DisplayIndications extends StatelessWidget {
  const DisplayIndications({
    Key key,
    this.requestId,
  }) : super(key: key);
  final String requestId;

  @override
  Widget build(BuildContext context) {
    IndicationRepository indicationrep = IndicationRepository(requestId);
    List<Indication> indications;
    final qqeur = Provider.of<DataUserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Indications Page'),
      ),
      body: Container(
        color: Colors.amber.shade100,
        child: StreamBuilder<QuerySnapshot>(
            stream: indicationrep.fetchIndicationAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                indications = snapshot.data.docs
                    .map((doc) => Indication.fromMap(doc.data(), doc.id))
                    .toList();
                return new ListView.builder(
                  itemCount: indications.length,
                  itemBuilder: (builContext, index) => Card(
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                indications[index].personIndicatedPhoto),
                          ),
                          Container(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    indications[index].personIndicatedName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.blue,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'indicado por ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    FutureBuilder(
                                      future: qqeur.getUserById(
                                          indications[index].userId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data["name"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.purple,
                                            ),
                                            textAlign: TextAlign.justify,
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('error');
                                        } else
                                          return Text('');
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  indications[index].knowledgeLevel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Builder(builder: (context) {
                                  if (indications[index].comments == null) {
                                    return Text(' ');
                                  } else {
                                    return Text(
                                      '${indications[index].comments}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.justify,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ],
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
                ));
              }
            }),
      ),
    );
  }
}
