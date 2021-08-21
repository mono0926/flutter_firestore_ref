import 'package:example/model/firestore/firestore.dart';
import 'package:example/model/service/service.dart';
import 'package:example/pages/user_counter_page.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final countIncrementer = Provider(
  (ref) {
    final read = ref.read;
    return () {
      final updateType = read(selectedUpdateType).state;
      logger.info('updateType: $updateType');
      final doc = read(myUserDocProvider).data?.value;
      if (doc == null) {
        throw AssertionError('_doc should not be null');
      }
      final user = doc.entity;
      if (user == null) {
        throw AssertionError('_doc.user should not be null');
      }
      final ref = doc.userRef;
      switch (updateType) {
        case UpdateType.add:
          ref.merge(user.incremented());
          break;
        case UpdateType.increment:
          ref.mergeData(
            ref.collectionRef.encode(user)
              ..[UserField.count] = FieldValue.increment(1),
          );
          break;
        case UpdateType.batch:
          runBatchWrite<void>((batch) {
            return ref.merge(
              user.incremented(),
              batch: batch,
            );
          });
          break;
        case UpdateType.transaction:
          FirebaseFirestore.instance.runTransaction((transaction) {
            return ref.update(
              user.incremented(),
              transaction: transaction,
            );
          });
          break;
      }
    };
  },
);
