import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_converter_helper/json_converter_helper.dart';

part 'paging_data.freezed.dart';
part 'paging_data.g.dart';

@freezed
class PagingData with _$PagingData {
  @allJsonConvertersSerializable
  const factory PagingData({
    @Default(0) int count,
    @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
    @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp updatedAt,
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
    DocumentSnapshot<JsonMap> snapshot,
    PagingDataRef docRef,
  ) {
    return PagingDataDoc(
      docRef,
      PagingData.fromJson(snapshot.data()!),
    );
  }

  @override
  JsonMap encode(PagingData data) {
    return data
        .copyWith(
          updatedAt: const UnionTimestamp.serverTimestamp(),
        )
        .toJson();
  }
}

class PagingDataRef extends DocumentRef<PagingData, PagingDataDoc> {
  const PagingDataRef({
    required super.ref,
    required PagingDatasRef collectionRef,
  }) : super(
          collectionRef: collectionRef,
        );
}
