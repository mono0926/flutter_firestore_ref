import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_data.freezed.dart';
part 'paging_data.g.dart';

@freezed
class PagingData with _$PagingData {
  const factory PagingData({
    @Default(0) int count,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _PagingData;
  factory PagingData.fromJson(JsonMap json) => _$PagingDataFromJson(json);
}

class PagingDataDoc extends Document<PagingData> {
  const PagingDataDoc(
    this.pagingDataRef,
    PagingData entity,
  ) : super(pagingDataRef, entity);

  final PagingDataRef pagingDataRef;
}

class PagingDatasRef
    extends CollectionRef<PagingData, PagingDataDoc, PagingDataRef> {
  PagingDatasRef()
      : super(
          FirebaseFirestore.instance.collection('pagings'),
        );

  @override
  PagingDataRef docRef(DocumentReference<JsonMap> ref) {
    return PagingDataRef(
      ref: ref,
      collectionRef: this,
    );
  }

  @override
  PagingDataDoc decode(
      DocumentSnapshot<JsonMap> snapshot, PagingDataRef docRef) {
    return PagingDataDoc(
      docRef,
      PagingData.fromJson(snapshot.data()!),
    );
  }

  @override
  JsonMap encode(PagingData data) {
    return replacingTimestamp(json: data.toJson());
  }
}

class PagingDataRef extends DocumentRef<PagingData, PagingDataDoc> {
  const PagingDataRef({
    required DocumentReference<JsonMap> ref,
    required PagingDatasRef collectionRef,
  }) : super(
          ref: ref,
          collectionRef: collectionRef,
        );
}
