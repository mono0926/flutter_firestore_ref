import 'dart:collection';

import 'package:example/model/firestore/firestore.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:subscription_holder/subscription_holder.dart';

class UsersNotifier extends ChangeNotifier {
  UsersNotifier() {
    _subscriptionHolder.add(
      usersRef
          // TODO(mono): Make Collection Group example
//      CollectionGroup<User, Document<User>>(
//        path: 'users',
//        decoder: usersRef.decoder,
//        encoder: usersRef.encoder,
//      )
          .documents((r) => r
              .orderBy(
                TimestampField.updatedAt,
                descending: true,
              )
              .limit(100))
          .listen((docs) {
        _userDocs = docs;
        notifyListeners();
      }),
    );
  }

  final _subscriptionHolder = SubscriptionHolder();
  List<Document<User>> _userDocs = [];
  List<Document<User>> get userDocs => UnmodifiableListView(_userDocs);

  Future<void> deleteAll() async {
    logger.info('[Start] deleteAll');
    final deletedIds = await usersRef.deleteAllDocuments(
      batchSize: 2,
    );
    logger..info('[End] deleteAll')..info('Deleted ids: $deletedIds');
  }

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
