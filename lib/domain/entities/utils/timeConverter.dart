import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampConverter {
  const TimestampConverter();

  DateTime deFirebase(Timestamp value) => value?.toDate();

  Timestamp paraFirebase(DateTime value) =>
      value != null ? Timestamp.fromDate(value) : null;
}
