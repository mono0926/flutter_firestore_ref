import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

typedef MakeGroupQuery = Query Function(Query collectionRef);

class CollectionGroup<E extends Entity, D extends Document<E>> {
  CollectionGroup({
    @required String path,
    @required this.decoder,
    @required this.encoder,
  }) : query = Firestore.instance.collectionGroup(path);
  @protected
  final Query query;
  @protected
  final DocumentDecoder<D> decoder;
  @protected
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots(MakeGroupQuery makeQuery) {
    return makeQuery(query).snapshots();
  }

  Stream<List<D>> documents(MakeGroupQuery makeQuery) {
    return snapshots(makeQuery)
        .map((snap) => snap.documents.map(decoder.decode).toList());
  }
}
