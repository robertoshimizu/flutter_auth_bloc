import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

class IndicationRepository extends ChangeNotifier {
  final String requestId;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference _api;
  List<Indication> indications;

  IndicationRepository(this.requestId) {
    _api = instance
        .collection('needRequest')
        .doc(requestId)
        .collection('indications');
  }

  Future<String> addIndication(Map data) async {
    var result = await _api.add(data);
    return result.id;
  }

  Future<void> deleteIndication(String docId) {
    return _api
        .doc(docId)
        .delete()
        .then((value) => print('indication ${this.requestId}  $docId deleted'))
        .catchError((error) => print('Failed to delete indications: $error'));
  }

  Stream<QuerySnapshot> fetchIndicationAsStream() {
    return _api.snapshots();
  }

  Stream<QuerySnapshot> fetchMyIndicationAsStream() {
    return _api.snapshots();
  }

  Future<List<Indication>> fetchIndications() async {
    var result = await _api.get();
    indications = result.docs
        .map((doc) => Indication.fromMap(doc.data(), doc.id))
        .toList();
    return indications;
  }
}

class MyIndicationRepository extends ChangeNotifier {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference _api;
  List<Indication> myindications = [];

  MyIndicationRepository() {
    _api = instance.collection('needRequest');
  }

  Future<List<Indication>> fetchMyIndications(String _user) async {
    List listOfIndications = await _api.get().then((val) => val.docs);

    for (int i = 0; i < listOfIndications.length; i++) {
      _api
          .doc(listOfIndications[i].documentID.toString())
          .collection("indications")
          .where('userId', isEqualTo: _user)
          .snapshots()
          .listen(createListofMyIndications);
    }
    return myindications;
  }

  createListofMyIndications(QuerySnapshot snapshot) {
    var docs = snapshot.docs;
    for (var doc in docs) {
      myindications.add(Indication.fromMap(doc.data(), doc.id));
    }
  }
}

// var query = _api.snapshots().forEach((val) {
//   val.docs.forEach((element) {
//     var subquery = _api
//         .doc(element.id)
//         .collection('indications')
//         .where('userId', isEqualTo: '5eb9628e08e7a36ab6141444')
//         .snapshots();
// subquery.forEach((element) {
//   element.docs.forEach((element) {
//     var leite = element.data()['userId'];
//     print('indications: $leite');
//   });
// });
//   });
// });

// var lista1 = [];

// var lista = await _api.get().then((value) => value.docs.forEach((element) {
//       var indics = element.data()['indications'];
//       print(indics);
//       pissa.add(element.id);
//     }));

// var lista = await _api.get().then((value) {
//   List<QueryDocumentSnapshot> lista2 = [];

//   return value.docs.forEach((element) async {
//     lista1.add(element.id);

//     var indics = await _api
//         .doc(element.id)
//         .collection('indications')
//         .where('userId', isEqualTo: '5eb9628e08e7a36ab6141444')
//         .get()
//         .then((value) => value.docs.forEach((element) {
//               lista2.add(element);
//               return lista2;
//             }));
//     print('lista2: $lista2');
//     return indics;

// lista3.addAll(lista2);
//   });
// });
// print('lista1: $lista1');
