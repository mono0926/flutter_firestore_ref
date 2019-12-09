import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final Firestore firestoreInstance = Firestore.instance;
void configureFirestore({
  bool persistenceEnabled = true,
  String host,
  bool sslEnabled,
  int cacheSizeBytes,
}) {
  assert(persistenceEnabled != null, 'persistenceEnabled should not be null');
  firestoreInstance.settings(
    persistenceEnabled: persistenceEnabled,
    host: host,
    sslEnabled: sslEnabled,
    cacheSizeBytes: cacheSizeBytes,
  );
}

extension FirRefDocumentSnapshotEx on DocumentSnapshot {
  Map<String, dynamic> get data => this.data;
}

extension FirRefCollectionReferenceEx on CollectionReference {
  Query orderBy(
    String field, {
    bool descending = false,
  }) =>
      this.orderBy(field, descending: descending);
}

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return json[key] == null ? null : (json[key] as Timestamp).toDate();
}
