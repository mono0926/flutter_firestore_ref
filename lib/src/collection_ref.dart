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
  const CollectionRef(
    this.ref, {
    @required this.decoder,
    @required this.encoder,
  });

  final CollectionReference ref;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots([MakeQuery makeQuery]) {
    return (makeQuery ?? (r) => r)(ref).snapshots();
  }

  Stream<List<D>> documents(MakeQuery makeQuery) {
    return snapshots(makeQuery)
        .map((snap) => snap.documents.map(decoder).toList());
  }

  DocumentRef<E, D> docRef([String id]) {
    return DocumentRef<E, D>(
      id: id,
      collectionRef: this,
    );
  }
}
