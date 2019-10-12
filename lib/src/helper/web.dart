import 'package:firebase/firebase.dart' hide Query;
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

Stream<QuerySnapshot> queryToSnapshots(Query query) {
  return query.onSnapshot;
}

Stream<DocumentSnapshot> documentRefToSnapshots(DocumentReference ref) {
  return ref.onSnapshot;
}

List<DocumentSnapshot> queryToDocumentSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs;
}

DocumentReference collectionToDocumentReference(
  CollectionReference ref, {
  @required String id,
}) {
  return ref.doc(id);
}

String getDocumentId(DocumentReference ref) {
  return ref.id;
}

String getSnapshotId(DocumentSnapshot snapshot) {
  return snapshot.id;
}

Map<String, dynamic> getSnapshotData(DocumentSnapshot snapshot) {
  return snapshot.data();
}

Future<void> updateRef(
  DocumentReference ref, {
  @required Map<String, dynamic> data,
  @required WriteBatch batch,
}) {
  if (batch == null) {
    return ref.update(data: data);
  } else {
    batch.update(ref, data: data);
    return Future.value(null);
  }
}

Future<void> setRef(
  DocumentReference ref, {
  Map<String, dynamic> data,
  bool merge = false,
  WriteBatch batch,
}) {
  if (batch == null) {
    return ref.set(data, SetOptions(merge: merge));
  } else {
    batch.set(ref, data, SetOptions(merge: merge));
    return Future.value(null);
  }
}

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return json[key] as DateTime;
}

CollectionReference collectionRef(String path) {
  return firestore().collection(path);
}

WriteBatch getBatch() {
  return firestore().batch();
}
