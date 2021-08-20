import 'package:example/model/firestore/firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDocsProvider = StreamProvider(
  (ref) => ref.watch(usersRefProvider).documents((r) => r
      .orderBy(
        TimestampField.updatedAt,
        descending: true,
      )
      .limit(100)),
);
