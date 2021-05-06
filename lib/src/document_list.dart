import 'package:firestore_ref/firestore_ref.dart';

class SnapshotHolder<E> {
  SnapshotHolder();

  final _documents = <DocumentSnapshot<E>>[];
  // TODO(mono): After https://github.com/FirebaseExtended/flutterfire/pull/3263 fixed, change key type to DocumentReference<E>
  final _map = <String, DocumentSnapshot<E>>{};

  SnapshotCollection<E> applyingSnapshot(QuerySnapshot<E> snapshot) {
    if (firestoreOperationCounter.enabled) {
      firestoreOperationCounter.recordRead(
        isFromCache: snapshot.metadata.isFromCache,
        count: snapshot.docChanges.length,
      );
    }
    for (final change in snapshot.docChanges) {
      final doc = change.doc;
      switch (change.type) {
        case DocumentChangeType.added:
          final docRef = doc.reference;
          _documents.insert(
            change.newIndex,
            doc,
          );
          _map[docRef.path] = doc;
          break;
        case DocumentChangeType.removed:
          _documents.removeAt(change.oldIndex);
          _map.remove(doc.reference);
          break;
        case DocumentChangeType.modified:
          final oldDoc = _documents.removeAt(change.oldIndex);
          final docRef = oldDoc.reference;
          _documents.insert(
            change.newIndex,
            doc,
          );
          _map[docRef.path] = doc;
          break;
      }
    }
    return SnapshotCollection<E>(
      list: List.unmodifiable(_documents),
      map: Map.unmodifiable(_map),
    );
  }
}

class SnapshotCollection<E> {
  SnapshotCollection({
    required this.list,
    required this.map,
  });
  SnapshotCollection.empty() : this(list: [], map: {});

  final List<DocumentSnapshot<E>> list;
  final Map<String, DocumentSnapshot<E>> map;

  bool get isEmpty => list.isEmpty && map.isEmpty;
}
