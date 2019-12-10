import 'package:firebase/firebase.dart' hide Query;
import 'package:firebase/firestore.dart';
import 'package:flutter/foundation.dart';

final Firestore firestoreInstance = firestore();

Future<void> configureFirestore({
  bool persistenceEnabled = true,
  String host = 'firestore.googleapis.com',
  bool sslEnabled = true,
  int cacheSizeBytes = 40 * 1024 * 1024, // 40MB
}) async {
  assert(persistenceEnabled != null, 'persistenceEnabled should not be null');
  if (persistenceEnabled) {
    await firestoreInstance.enablePersistence();
  }
  firestoreInstance.settings(Settings(
    host: host,
    ssl: sslEnabled,
    cacheSizeBytes: cacheSizeBytes,
  ));
}

extension FirRefQueryEx on Query {
  Stream<QuerySnapshot> snapshots() => onSnapshot;
}

extension FirRefDocumentReferenceEx on DocumentReference {
  Stream<DocumentSnapshot> snapshots() => onSnapshot;
  String get documentID => id;

  Future<void> updateData(Map<String, dynamic> data) => update(data: data);

  Future<void> setData(Map<String, dynamic> data, {bool merge = false}) =>
      set(data, SetOptions(merge: merge));
}

extension FirRefBatchEx on WriteBatch {
  void updateData(DocumentReference document, Map<String, dynamic> data) =>
      update(
        document,
        data: data,
      );

  void setData(
    DocumentReference document,
    Map<String, dynamic> data, {
    bool merge = false,
  }) =>
      set(
        document,
        data,
        SetOptions(merge: merge),
      );
}

extension FirRefQuerySnapshotEx on QuerySnapshot {
  List<DocumentSnapshot> get documents => docs;
}

extension FirRefCollectionReferenceEx on CollectionReference {
  DocumentReference document([String path]) => doc(path);

  Query orderBy(
    String field, {
    bool descending = false,
  }) =>
      this.orderBy(field, descending ? 'desc' : 'asc');
}

extension FirRefDocumentSnapshotEx on DocumentSnapshot {
  String get documentID => id;
  Map<String, dynamic> get data => this.data();
}

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return json[key] as DateTime;
}
