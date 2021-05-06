import 'package:example/model/firestore/firestore.dart';
import 'package:example/model/service/service.dart';
import 'package:example/pages/user_counter_page.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subscription_holder/subscription_holder.dart';
import 'package:rxdart/rxdart.dart';

final myNotifier =
    ChangeNotifierProvider.autoDispose((ref) => MyNotifier(ref.read));

class MyNotifier extends ChangeNotifier {
  MyNotifier(this._read) {
    _subscriptionHolder.add(
      _read(authenticator)
          .userStream
          .switchMap((user) {
            final userId = user?.uid;
            return userId == null
                ? const Stream<DocumentSnapshot<User>>.empty()
                : usersRef.doc(userId).snapshots();
          })
          .where((doc) => _doc != doc)
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
        ref.set(
          user.copyWith(count: count + 1),
        );
        break;
      case UpdateType.increment:
        FirebaseFirestore.instance.doc(ref.path).set(
              toFirestoreFromUser(user)
                ..[UserField.count] = FieldValue.increment(1),
              SetOptions(merge: true),
            );
        break;
      case UpdateType.batch:
        runBatchWrite<void>((batch) async {
          batch.set(
            ref,
            user.copyWith(count: count + 1),
          );
        });
        break;
      case UpdateType.transaction:
        FirebaseFirestore.instance.runTransaction((transaction) async {
          // TODO(mono): merge isn't supported
          // https://github.com/FirebaseExtended/flutterfire/issues/1212
          transaction.set(
            ref,
            user.copyWith(count: count + 1),
          );
        });
        break;
    }
  }

  final _subscriptionHolder = SubscriptionHolder();
  DocumentSnapshot<User>? _doc;
  DocumentSnapshot<User>? get doc => _doc;
  String? get id => doc?.id;
  User get user => doc?.data() ?? const User(count: 0);
  int get count => user.count;
  DocumentReference<User>? get _ref => _doc?.reference;

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
