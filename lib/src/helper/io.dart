import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final Firestore firestoreInstance = Firestore.instance;

void configureFirestore({bool persistenceEnabled = true}) {
  assert(persistenceEnabled != null, 'persistenceEnabled should not be null');
  firestoreInstance.settings(persistenceEnabled: persistenceEnabled);
}

Stream<QuerySnapshot> queryToSnapshots(Query query) {
  return query.snapshots();
}

Stream<DocumentSnapshot> documentRefToSnapshots(DocumentReference ref) {
  return ref.snapshots();
}

List<DocumentSnapshot> queryToDocumentSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents;
}

DocumentReference collectionToDocumentReference(
  CollectionReference ref, {
  @required String id,
}) {
  return ref.document(id);
}

String getDocumentId(DocumentReference ref) {
  return ref.documentID;
}

String getSnapshotId(DocumentSnapshot snapshot) {
  return snapshot.documentID;
}

Map<String, dynamic> getSnapshotData(DocumentSnapshot snapshot) {
  return snapshot.data;
}

Future<void> updateRef(
  DocumentReference ref, {
  @required Map<String, dynamic> data,
  @required WriteBatch batch,
}) {
  if (batch == null) {
    return ref.updateData(data);
  } else {
    batch.updateData(ref, data);
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
    return ref.setData(data, merge: merge);
  } else {
    batch.setData(ref, data, merge: merge);
    return Future.value(null);
  }
}

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return json[key] == null ? null : (json[key] as Timestamp).toDate();
}

Query orderBy(
  CollectionReference ref, {
  @required String field,
  bool descending = false,
}) {
  return ref.orderBy(field, descending: descending);
}
