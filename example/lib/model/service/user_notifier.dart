import 'package:example/model/firestore/firestore.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:subscription_holder/subscription_holder.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier({
    @required String id,
    @required this.read,
  }) {
    _doc = Document<User>(usersRef.docRef(id).ref, null);
    if (id != null) {
      _subscriptionHolder.add(
        _ref.document().listen((doc) {
          if (doc != null && _doc != doc) {
            _doc = doc;
            notifyListeners();
          }
        }),
      );
    }
  }

  final Locator read;

  void increment() {
    final updateType = read<HomePageController>().updateType;
    logger.info('updateType: $updateType');
    switch (updateType) {
      case UpdateType.add:
        _ref.merge(user.copyWith(count: count + 1));
        break;
      case UpdateType.increment:
        _ref.mergeData(
          _ref.collectionRef.encoder(user)
            ..[UserField.count] = FieldValue.increment(1),
        );
        break;
      case UpdateType.batch:
        runBatchWrite<void>((batch) {
          return _ref.merge(
            user.copyWith(count: count + 1),
            batch: batch,
          );
        });
        break;
      case UpdateType.transaction:
        Firestore.instance.runTransaction((transaction) {
          // TODO(mono): merge isn't supported
          // https://github.com/FirebaseExtended/flutterfire/issues/1212
          return _ref.update(
            user.copyWith(count: count + 1),
            transaction: transaction,
          );
        });
        break;
    }
  }

  final _subscriptionHolder = SubscriptionHolder();
  Document<User> _doc;
  Document<User> get doc => _doc;
  String get id => doc.id;
  User get user => doc.entity ?? const User(count: 0);
  int get count => user.count;
  DocumentRef<User, Document<User>> get _ref => usersRef.docRef(id);

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
