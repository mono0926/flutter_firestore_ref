import 'package:example/model/firestore/firestore.dart';
import 'package:example/model/service/service.dart';
import 'package:example/pages/user_counter_page.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:subscription_holder/subscription_holder.dart';

final myNotifier =
    ChangeNotifierProvider.autoDispose((ref) => MyNotifier(ref.read));

class MyNotifier extends ChangeNotifier {
  MyNotifier(this._read) {
    _subscriptionHolder.add(
      _read(authenticator.notifier)
          .streamWithCurrent
          .switchMap((user) {
            final userId = user?.uid;
            final doc = userId == null
                ? null
                : UserDoc(usersRef.docRefWithId(userId), null);
            _doc = doc;
            return doc == null
                ? const Stream<UserDoc>.empty()
                : doc.userRef.document();
          })
          .where((doc) => doc != null && _doc != doc)
          .listen((doc) {
            _doc = doc;
            notifyListeners();
          }),
    );
  }

  final Reader _read;

  void increment() {
    final updateType = _read(homePageController).updateType;
    logger.info('updateType: $updateType');
    final ref = _ref;
    if (ref == null) {
      throw AssertionError('_ref should not be null');
    }
    switch (updateType) {
      case UpdateType.add:
        ref.merge(user.copyWith(count: count + 1));
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
            user.copyWith(count: count + 1),
            batch: batch,
          );
        });
        break;
      case UpdateType.transaction:
        FirebaseFirestore.instance.runTransaction((transaction) {
          // TODO(mono): merge isn't supported
          // https://github.com/FirebaseExtended/flutterfire/issues/1212
          return ref.update(
            user.copyWith(count: count + 1),
            transaction: transaction,
          );
        });
        break;
    }
  }

  final _subscriptionHolder = SubscriptionHolder();
  UserDoc? _doc;
  UserDoc? get doc => _doc;
  String? get id => doc?.id;
  User get user => doc?.entity ?? const User(count: 0);
  int get count => user.count;
  UserRef? get _ref => _doc?.userRef;

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
