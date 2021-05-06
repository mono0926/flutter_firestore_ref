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
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _PagingData;
  factory PagingData.fromJson(Map<String, dynamic> json) =>
      _$PagingDataFromJson(json);
}

final pagingDatasRef =
    FirebaseFirestore.instance.collection('pagings').withConverter(
          fromFirestore: (snapshot, _) => PagingData.fromJson(
            snapshot.data()!,
          ),
          toFirestore: (pagingData, _) => replacingTimestamp(
            json: pagingData.toJson(),
          ),
        );
