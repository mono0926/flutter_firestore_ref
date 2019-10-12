import 'dart:collection';

import 'package:example/model/firestore/firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:subscription_holder/subscription_holder.dart';

class UsersNotifier extends ChangeNotifier {
  UsersNotifier() {
    _subscriptionHolder.add(
      UsersRef.ref()
          .documents((r) => orderBy(
                r,
                field: EntityField.updatedAt,
                descending: true,
              ))
          .listen((docs) {
        _userDocs = docs;
        notifyListeners();
      }),
    );
  }

  final _subscriptionHolder = SubscriptionHolder();
  List<UserDoc> _userDocs = [];
  List<UserDoc> get userDocs => UnmodifiableListView(_userDocs);

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
