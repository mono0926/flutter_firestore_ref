import 'package:example/model/firestore/firestore.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:subscription_holder/subscription_holder.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier({@required Document<User> doc}) {
    _doc = doc;
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

  UserNotifier.fromId(String id) : this(doc: Document<User>(id, null));

  void increment() {
    logger.info(DateTime.now());
    _ref.merge(user.copyWith(count: count + 1));
  }

  final _subscriptionHolder = SubscriptionHolder();
  Document<User> _doc;
  Document<User> get doc => _doc;
  String get id => doc.id;
  User get user => doc.entity ?? const User(count: 0);
  int get count => user.count;
  DocumentRef<User, Document<User>> get _ref => UsersRef.ref().docRef(id);

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
