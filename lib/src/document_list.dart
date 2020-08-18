import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

class DocumentList<E, D extends Document<E>> {
  DocumentList({
    @required this.decoder,
  });

  final DocumentDecoder<D> decoder;
  final _documents = <D>[];
  final _map = <DocumentReference, D>{};

  DocumentListResult<D> applyingSnapshot(QuerySnapshot snapshot) {
    if (recordFirestoreOperationCount) {
      FirestoreOperationCounter.instance.recordRead(
        isFromCache: snapshot.metadata.isFromCache,
        count: snapshot.docChanges.length,
      );
    }
    for (final change in snapshot.docChanges) {
      final doc = change.doc;
      switch (change.type) {
        case DocumentChangeType.added:
          final decoded = decoder(doc);
          _documents.insert(
            change.newIndex,
            decoded,
          );
          _map[doc.reference] = decoded;
          break;
        case DocumentChangeType.removed:
          _documents.removeAt(change.oldIndex);
          _map.remove(doc.reference);
          break;
        case DocumentChangeType.modified:
          final decoded = decoder(doc);
          _documents.removeAt(change.oldIndex);
          _documents.insert(
            change.newIndex,
            decoded,
          );
          _map[doc.reference] = decoded;
          break;
      }
    }
    return DocumentListResult(
      list: List.unmodifiable(_documents),
      map: Map.unmodifiable(_map),
    );
  }
}
