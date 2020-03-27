import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

class DocumentList<E, D extends Document<E>> {
  DocumentList({
    @required this.decoder,
  });
  final DocumentDecoder<D> decoder;
  final _documents = <D>[];

  List<D> applyingSnapshot(QuerySnapshot snapshot) {
    for (final change in snapshot.documentChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
          _documents.insert(
            change.newIndex,
            decoder(change.document),
          );
          break;
        case DocumentChangeType.removed:
          _documents.removeAt(change.oldIndex);
          break;
        case DocumentChangeType.modified:
          _documents.removeAt(change.oldIndex);
          _documents.insert(
            change.newIndex,
            decoder(change.document),
          );
          break;
      }
    }
    return List.unmodifiable(_documents);
  }
}
