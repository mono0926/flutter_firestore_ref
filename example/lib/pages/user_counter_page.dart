import 'package:cloud_functions/cloud_functions.dart';
import 'package:example/model/service/service.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCounterPage extends StatelessWidget {
  const UserCounterPage._({Key key}) : super(key: key);

  static const routeName = '/user_counter';

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersNotifier()),
        ChangeNotifierProvider(create: (context) => HomePageController()),
      ],
      child: const UserCounterPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pascalCaseFromRouteName(routeName),
        ),
        actions: const [
          _DropdownButton(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CupertinoSlidingSegmentedControl<UpdateType>(
              children: const {
                UpdateType.add: Text('Add'),
                UpdateType.increment: Text('Incr'),
                UpdateType.batch: Text('Batch'),
                UpdateType.transaction: Text('Tran'),
              },
              onValueChanged: (type) {
                context.read<HomePageController>().changeUpdateType(type);
              },
              groupValue:
                  context.select((HomePageController c) => c.updateType),
            ),
          ),
          const Divider(height: 0),
          const _AccountStatus(),
          ChangeNotifierProxyProvider<Authenticator, UserNotifier>(
            create: null,
            update: (context, authenticator, previous) => UserNotifier(
              id: authenticator.user?.uid,
              read: context.read,
            ),
            child: const _MyCounter(),
          ),
          const Divider(),
          const Expanded(
            child: _Users(),
          ),
        ],
      ),
    );
  }
}

class _DropdownButton extends StatelessWidget {
  const _DropdownButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(
            'Delete All',
            style: TextStyle(
              color: colorScheme.error,
            ),
          ),
          value: 'deleteAll',
        ),
      ],
      onSelected: (value) {
        logger.info(value);
        context.read<UsersNotifier>().deleteAll();
      },
    );
  }
}

class _AccountStatus extends StatelessWidget {
  const _AccountStatus({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authenticator = context.watch<Authenticator>();

    return ListTile(
      title: const Text('User ID'),
      subtitle: Text(
        authenticator.user?.uid ?? '0',
      ),
    );
  }
}

class _MyCounter extends StatelessWidget {
  const _MyCounter({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('My Count'),
      subtitle: Text(
        context.select((UserNotifier n) => n.count.toString()),
      ),
      trailing: IconButton(
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        onPressed: () async {
          context.read<UserNotifier>().increment();

          final result = await CloudFunctions.instance
              .getHttpsCallable(functionName: 'now')
              .call();
          logger.info(result.data);
        },
      ),
    );
  }
}

class _Users extends StatelessWidget {
  const _Users({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authenticator = context.watch<Authenticator>();
    final notifier = context.watch<UsersNotifier>();
    final docs = notifier.userDocs;
    return ListView.builder(
      itemBuilder: (context, index) {
        final doc = docs[index];
        return Container(
          key: ValueKey(doc.id),
          color: authenticator.user?.uid == doc.id ? Colors.green[100] : null,
          child: ListTile(
            title: Text(doc.id),
            subtitle: Text('count: ${doc.entity.count}'),
          ),
        );
      },
      itemCount: docs.length,
    );
  }
}

class HomePageController with ChangeNotifier {
  var _updateType = UpdateType.add;

  UpdateType get updateType => _updateType;

  void changeUpdateType(UpdateType type) {
    _updateType = type;
    notifyListeners();
  }
}

enum UpdateType {
  add,
  increment,
  batch,
  transaction,
}
