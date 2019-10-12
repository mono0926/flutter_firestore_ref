import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

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

CollectionReference collectionRef(String path) {
  return Firestore.instance.collection(path);
}

WriteBatch getBatch() {
  return Firestore.instance.batch();
}
