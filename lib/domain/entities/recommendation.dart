class Indication {
  String indicationId;
  DateTime indicationDate;
  String userId;
  String requestId;
  String personIndicatedId;
  String personIndicatedName;
  String personIndicatedPhoto;
  String knowledgeLevel;
  String comments;

  Indication({
    this.indicationId,
    this.indicationDate,
    this.userId,
    this.requestId,
    this.personIndicatedId,
    this.personIndicatedName,
    this.personIndicatedPhoto,
    this.knowledgeLevel,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'indicationDate': indicationDate,
      'userId': userId,
      'requestId': requestId,
      'personIndicatedId': personIndicatedId,
      'personIndicatedName': personIndicatedName,
      'personIndicatedPhoto': personIndicatedPhoto,
      'knowledgeLevel': knowledgeLevel,
      'comments': comments,
    };
  }

  // Se fizer fromMap(), não esquecer de adicionar indicationId -> doc.referenceID
  static Indication fromMap(Map<String, dynamic> map, String indicationId) {
    if (map == null) return null;

    return Indication(
      requestId: map['requestId'],
      indicationDate: DateTime.fromMillisecondsSinceEpoch(
          map['indicationDate'].millisecondsSinceEpoch),
      userId: map['userId'],
      knowledgeLevel: map['knowledgeLevel'],
      personIndicatedId: map['personIndicatedId'],
      personIndicatedName: map['personIndicatedName'],
      personIndicatedPhoto: map['personIndicatedPhoto'],
      comments: map['comments'],
    );
  }
}
