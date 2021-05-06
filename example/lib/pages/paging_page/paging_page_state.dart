import 'package:example/pages/paging_page/paging_data.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_page_state.freezed.dart';

@freezed
abstract class PagingPageState with _$PagingPageState {
  factory PagingPageState({
    @Default(<DocumentSnapshot<PagingData>>[])
        List<DocumentSnapshot<PagingData>> docs,
    @Default(true) bool hasMore,
  }) = _PagingPageState;
  PagingPageState._();

  late final String info = '${docs.length} / ${hasMore ? '?' : docs.length}';
}
