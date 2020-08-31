import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

class DocumentList<E, D extends Document<E>, DocRef extends DocumentRef<E, D>> {
  DocumentList({
    @required this.docRefCreator,
    @required this.decoder,
  });

  final DocRefCreator<E, D, DocRef> docRefCreator;
  final DocumentDecoder<E, D, DocRef> decoder;
  final _documents = <D>[];
  final _map = <DocRef, D>{};

  DocumentListResult<E, D, DocRef> applyingSnapshot(QuerySnapshot snapshot) {
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
          final docRef = docRefCreator(doc.reference);
          final decoded = decoder(
            doc,
            docRef,
          );
          _documents.insert(
            change.newIndex,
            decoded,
          );
          _map[docRef] = decoded;
          break;
        case DocumentChangeType.removed:
          _documents.removeAt(change.oldIndex);
          _map.remove(doc.reference);
          break;
        case DocumentChangeType.modified:
          final oldDoc = _documents.removeAt(change.oldIndex);
          final docRef = oldDoc.ref as DocRef;
          final decoded = decoder(
            doc,
            docRef,
          );
          _documents.insert(
            change.newIndex,
            decoded,
          );
          _map[docRef] = decoded;
          break;
      }
    }
    return DocumentListResult<E, D, DocRef>(
      list: List.unmodifiable(_documents),
      map: Map.unmodifiable(_map),
    );
  }
}
