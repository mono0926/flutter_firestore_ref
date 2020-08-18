import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paging_data.freezed.dart';
part 'paging_data.g.dart';

@freezed
abstract class PagingData with _$PagingData {
  const factory PagingData({
    @Default(0) int count,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _PagingData;
  factory PagingData.fromJson(Map<String, dynamic> json) =>
      _$PagingDataFromJson(json);
}

class PagingDataDoc extends Document<PagingData> {
  const PagingDataDoc(
    DocumentReference ref,
    PagingData entity,
  ) : super(ref, entity);
}

class PagingDatasRef extends CollectionRef<PagingData, PagingDataDoc> {
  PagingDatasRef()
      : super(
          FirebaseFirestore.instance.collection('pagings'),
          decoder: (snapshot) => PagingDataDoc(
            snapshot.reference,
            PagingData.fromJson(snapshot.data()),
          ),
          encoder: (data) => replacingTimestamp(json: data.toJson()),
        );

  @override
  PagingDataRef docRef([String id]) {
    return PagingDataRef(
      id: id,
      collectionRef: this,
    );
  }
}

class PagingDataRef extends DocumentRef<PagingData, PagingDataDoc> {
  PagingDataRef({
    @required String id,
    @required PagingDatasRef collectionRef,
  }) : super(
          id: id,
          collectionRef: collectionRef,
        );
}
