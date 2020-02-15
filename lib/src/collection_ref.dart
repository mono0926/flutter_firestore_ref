import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

typedef MakeQuery = Query Function(CollectionReference collectionRef);

@immutable
abstract class CollectionRef<E, D extends Document<E>> {
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
    return makeQuery(ref).snapshots();
  }

  Stream<List<D>> documents(MakeQuery makeQuery) {
    return snapshots(makeQuery)
        .map((snap) => snap.documents.map(decoder).toList());
  }

  @protected
  DocumentReference docRefRaw([String id]) => ref.document(id);

  DocumentRef<E, D> docRef([String id]);
}
