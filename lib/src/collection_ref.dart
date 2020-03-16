import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

typedef MakeQuery = Query Function(CollectionReference collectionRef);
typedef DocumentDecoder<D extends Document<dynamic>> = D Function(
    DocumentSnapshot snapshot);
typedef EntityEncoder<E> = Map<String, dynamic> Function(
  E entity,
);

@immutable
class CollectionRef<E, D extends Document<E>> {
  CollectionRef(
    this.ref, {
    @required this.decoder,
    @required this.encoder,
  }) : _documentList = _DocumentList(decoder: decoder);

  final CollectionReference ref;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;
  final _DocumentList<E, D> _documentList;

  Stream<QuerySnapshot> snapshots([MakeQuery makeQuery]) {
    return (makeQuery ?? (r) => r)(ref).snapshots();
  }

  Stream<List<D>> documents([MakeQuery makeQuery]) {
    return snapshots(makeQuery ?? (r) => r).map(_documentList.appliedSnapshot);
  }

  Future<QuerySnapshot> getSnapshots([MakeQuery makeQuery]) {
    return (makeQuery ?? (r) => r)(ref).getDocuments();
  }

  Future<List<D>> getDocuments([MakeQuery makeQuery]) async {
    final snapshots = await getSnapshots(makeQuery);
    return snapshots.documents.map(decoder).toList();
  }

  DocumentRef<E, D> docRef([String id]) {
    return DocumentRef<E, D>(
      id: id,
      collectionRef: this,
    );
  }

  Future<DocumentRef<E, D>> add(E entity) async {
    final rawRef = await ref.add(encoder(entity));
    return docRef(rawRef.documentID);
  }
}

class _DocumentList<E, D extends Document<E>> {
  _DocumentList({
    @required this.decoder,
  });
  final DocumentDecoder<D> decoder;
  final _documents = <D>[];

  List<D> appliedSnapshot(QuerySnapshot snapshot) {
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
