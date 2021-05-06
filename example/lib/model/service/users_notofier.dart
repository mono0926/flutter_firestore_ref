import 'dart:collection';

import 'package:example/model/firestore/firestore.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subscription_holder/subscription_holder.dart';

final usersNotifier =
    ChangeNotifierProvider.autoDispose((ref) => UsersNotifier());

class UsersNotifier extends ChangeNotifier {
  UsersNotifier() {
    _subscriptionHolder.add(
      usersRef
          // TODO(mono): Make Collection Group example
//      CollectionGroup<User, UserDoc>(
//        path: 'users',
//        decoder: usersRef.decoder,
//        encoder: usersRef.encoder,
//      )
          .orderBy(
            TimestampField.updatedAt,
            descending: true,
          )
          .limit(100)
          .snapshots()
          .listen((snapshot) {
        _userDocs = snapshot.docs;
        notifyListeners();
      }),
    );
  }

  final _subscriptionHolder = SubscriptionHolder();
  List<DocumentSnapshot<User>> _userDocs = [];
  List<DocumentSnapshot<User>> get userDocs => UnmodifiableListView(_userDocs);

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
