import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_converter_helper/json_converter_helper.dart';

part 'paging_data.freezed.dart';
part 'paging_data.g.dart';

@freezed
class PagingData with _$PagingData {
  @allJsonConvertersSerializable
  const factory({
    @Default(0) int count,
    @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
    @UnionTimestampConverter.alwaysServerTimestampConverter
    @Default(UnionTimestamp.serverTimestamp())
    UnionTimestamp updatedAt,
  }) = _PagingData;
  factory fromJson(JsonMap json) => _$PagingDataFromJson(json);
}

// ignore: use_super_parameters
class const PagingDataDoc(
  final PagingDataRef pagingDataRef,
  PagingData entity,
) extends Document<PagingData> {
  this : super(pagingDataRef, entity);
}

// ignore: prefer_const_constructors_in_immutables
class PagingDatasRef()
    extends CollectionRef<PagingData, PagingDataDoc, PagingDataRef> {
  this
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
  JsonMap encode(PagingData data) => data.toJson();
}

class const PagingDataRef({
  required super.ref,
  required PagingDatasRef collectionRef,
}) extends DocumentRef<PagingData, PagingDataDoc> {
  this
    : super(
        collectionRef: collectionRef,
      );
}
