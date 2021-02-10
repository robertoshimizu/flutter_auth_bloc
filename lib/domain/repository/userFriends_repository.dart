import 'package:cloud_firestore/cloud_firestore.dart';

class MyContacts {
  final String userId;

  MyContacts({
    this.userId,
  });
  //WidgetsFlutterBinding.ensureInitialized();
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  Stream<QuerySnapshot> userFriendsCollection() {
    return instance
        .collection('users')
        .doc(userId)
        .collection('userFriends')
        .snapshots();
  }

  Stream<QuerySnapshot> needRequestCollection() {
    return instance.collection('needRequest').snapshots();
  }
}

// instance
//         .collection('users')
//         .document('5eb9628e12228e8edfa5dc9a')
//         .collection('userFriends')
//         .snapshots()
//         .listen((data) =>
//             data.documents.forEach((friend) => print(friend["name"])));
