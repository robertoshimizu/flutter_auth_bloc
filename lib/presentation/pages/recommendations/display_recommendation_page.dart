import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';
import 'package:flutter_auth_bloc/presentation/pages/chat/chat_create_new.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class DisplayIndications extends StatelessWidget {
  DisplayIndications({
    Key key,
    this.requestId,
  }) : super(key: key);
  final String requestId;

  final AuthRepository _authRepository = locator<DataAuthRepository>();

  @override
  Widget build(BuildContext context) {
    AppUser _user = _authRepository.user;
    IndicationRepository indicationrep = IndicationRepository(requestId);
    List<Indication> indications;
    final qqeur = Provider.of<DataUserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Indicações Recebidas'),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                    indications[index].personIndicatedPhoto),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Container(
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        indications[index].personIndicatedName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  indications[index].knowledgeLevel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 8,
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
                                      textAlign: TextAlign.left,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_rate_outlined,
                                  size: 18,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            (_user.uid == indications[index].userId)
                                ? IconButton(
                                    iconSize: 20,
                                    icon: Icon(
                                      Icons.chat,
                                      color: Colors.black87,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewChat(
                                                  indications[index]
                                                      .personIndicatedId)));
                                    })
                                : SizedBox(
                                    width: 48,
                                    height: 38,
                                  ),
                          ],
                        ),
                      ],
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
