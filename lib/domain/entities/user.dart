import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppUser extends Equatable with ChangeNotifier {
  final String uid;
  final String mobilePhone;

  AppUser({
    this.uid,
    this.mobilePhone,
  });

  @override
  List<Object> get props => [uid, mobilePhone];

  static var empty = AppUser(uid: '', mobilePhone: '');
}

// Custom Class for Firestore UserData

class UserData {
  final String uid;
  final String name;
  final String nickname;
  final String mobilePhone1;
  final String phone1;
  final String photo;
  final DateTime registered;
  final String occupation;
  final String address;
  final String idtype;
  final String id;
  final String gender;
  final String about;
  final String cpf;
  final String companyName;
  final String birthdate;

  UserData({
    this.uid,
    this.name,
    this.nickname,
    this.mobilePhone1,
    this.phone1,
    this.photo,
    this.registered,
    this.address,
    this.occupation,
    this.idtype,
    this.id,
    this.gender,
    this.about,
    this.cpf,
    this.companyName,
    this.birthdate,
  });

  UserData.fromMap(Map snapshot, String uid)
      : uid = uid ?? '',
        name = snapshot['name'] ?? '',
        nickname = snapshot['nickname'] ?? '',
        mobilePhone1 = snapshot['mobile_phone1'] ?? '',
        phone1 = snapshot['phone1'] ?? '',
        photo = snapshot['photo'] ?? '',
        registered = snapshot['registered'].runtimeType == String
            ? DateTime.parse(snapshot['registered'])
            : snapshot['registered'].toDate(),
        // registered = DateTime.fromMicrosecondsSinceEpoch(
        //         snapshot['registered'].microsecondsSinceEpoch) ??
        //     '',
        // This is when registerd is a timestamp. above is when it is a string
        address = snapshot['address'] ?? '',
        occupation = snapshot['occupation'] ?? '',
        idtype = snapshot['idtype'] ?? '',
        id = snapshot['id'] ?? '',
        gender = snapshot['gender'] ?? '',
        about = snapshot['about'] ?? '',
        cpf = snapshot['cpf'] ?? '',
        companyName = snapshot['company_name'] ?? '',
        birthdate = snapshot['birthdate'] ?? '';

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "nickname": nickname,
      "mobile_phone1": mobilePhone1,
      "phone1": phone1,
      "photo": photo,
      "registered": Timestamp.fromDate(
          registered), // IMPORTANTE, acomplando classe de Firebase!!!
      "address": address,
      "occupation": occupation,
      "idtype": idtype,
      "id": id,
      "gender": gender,
      "about": about,
      "cpf": cpf,
      "company_name": companyName,
      "birthdate": birthdate,
    };
  }
}
