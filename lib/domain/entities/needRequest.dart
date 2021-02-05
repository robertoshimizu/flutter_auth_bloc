import 'dart:convert';

class NeedRequest {
  String requestId;
  DateTime creationDate;
  DateTime expiringDate;
  String userId;
  String description;
  List<String> destinationFriends;
  String serviceClassification;
  List<String> indications;
  List<String> applications;

  NeedRequest({
    this.requestId,
    this.creationDate,
    this.expiringDate,
    this.userId,
    this.description,
    this.destinationFriends,
    this.serviceClassification,
    this.indications,
    this.applications,
  });

  Map<String, dynamic> toMap() {
    return {
      'creationDate': creationDate,
      'expiringDate': expiringDate,
      'userId': userId,
      'description': description,
      'destinationFriends': destinationFriends,
      'serviceClassification': serviceClassification,
      'indications': indications,
      'applications': applications,
    };
  }

  static NeedRequest fromMap(Map<String, dynamic> map, String requestId) {
    if (map == null) return null;

    return NeedRequest(
      requestId: requestId ?? '',
      creationDate: DateTime.fromMillisecondsSinceEpoch(
          map['creationDate'].millisecondsSinceEpoch),
      expiringDate: DateTime.fromMillisecondsSinceEpoch(
          map['expiringDate'].millisecondsSinceEpoch),
      userId: map['userId'],
      description: map['description'],
      destinationFriends: List<String>.from(map['destinationFriends']),
      serviceClassification: map['serviceClassification'],
      indications: List<String>.from(map['indications']),
      applications: List<String>.from(map['applications']),
    );
  }

  String toJson() => json.encode(toMap());

  NeedRequest fromJson(String source) =>
      fromMap(json.decode(source), requestId);
}
