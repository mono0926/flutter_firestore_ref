import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/helper/helper.dart';
import 'package:meta/meta.dart';

import 'firestore.dart';

typedef MakeQuery = Query Function(CollectionReference collectionRef);

@immutable
class CollectionRef<E extends Entity, D extends Document<E>> {
  const CollectionRef({
    @required this.ref,
    @required this.decoder,
    @required this.encoder,
  });

  @protected
  final CollectionReference ref;
  @protected
  final DocumentDecoder<D> decoder;
  @protected
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots(MakeQuery makeQuery) {
    return queryToSnapshots(makeQuery(ref));
  }

  Stream<List<D>> documents(MakeQuery makeQuery) {
    return snapshots(makeQuery).map(
        (snap) => queryToDocumentSnapshot(snap).map(decoder.decode).toList());
  }

  @protected
  DocumentReference docRefRaw([String id]) =>
      collectionToDocumentReference(ref, id: id);

  DocumentRef<E, D> docRef([String id]) {
    return DocumentRef<E, D>(
      ref: docRefRaw(id),
      decoder: decoder,
      encoder: encoder,
    );
  }
}
