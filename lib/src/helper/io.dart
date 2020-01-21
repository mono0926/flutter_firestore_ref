import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore firestoreInstance = Firestore.instance;
Future<void> configureFirestore({
  bool persistenceEnabled = true,
  String host,
  bool sslEnabled,
  int cacheSizeBytes,
}) async {
  assert(persistenceEnabled != null, 'persistenceEnabled should not be null');
  await firestoreInstance.settings(
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
