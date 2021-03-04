import 'package:cloud_functions/cloud_functions.dart';
import 'package:example/model/service/service.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCounterPage extends HookWidget {
  const UserCounterPage({Key? key}) : super(key: key);

  static const routeName = '/user_counter';

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
                context.read(homePageController).changeUpdateType(type!);
              },
              groupValue:
                  useProvider(homePageController.select((c) => c.updateType)),
            ),
          ),
          const Divider(height: 0),
          const _AccountStatus(),
          const _MyCounter(),
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
  const _DropdownButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'deleteAll',
          child: Text(
            'Delete All',
            style: TextStyle(
              color: colorScheme.error,
            ),
          ),
        ),
      ],
      onSelected: (value) {
        logger.info(value);
        context.read(usersNotifier).deleteAll();
      },
    );
  }
}

class _AccountStatus extends HookWidget {
  const _AccountStatus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('User ID'),
      subtitle: Text(
        useProvider(
          authenticator
              .select((authenticator) => authenticator.user?.uid ?? '0'),
        ),
      ),
    );
  }
}

class _MyCounter extends HookWidget {
  const _MyCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('My Count'),
      subtitle: Text(
        useProvider(myNotifier.select((n) => '${n.count}')),
      ),
      trailing: IconButton(
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        onPressed: () async {
          context.read(myNotifier).increment();
          final result =
              await FirebaseFunctions.instance.httpsCallable('now').call<Map>();
          logger.info(result.data);
        },
      ),
    );
  }
}

class _Users extends HookWidget {
  const _Users({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = useProvider(usersNotifier);
    final docs = notifier.userDocs;
    final myId = useProvider(authenticator).user?.uid;
    return ListView.builder(
      itemBuilder: (context, index) {
        final doc = docs[index];
        return Container(
          key: ValueKey(doc.id),
          color: myId == doc.id ? Colors.green[100] : null,
          child: ListTile(
            title: Text(doc.id),
            subtitle: Text('count: ${doc.entity!.count}'),
          ),
        );
      },
      itemCount: docs.length,
    );
  }
}

final homePageController = ChangeNotifierProvider.autoDispose(
  (ref) => HomePageController(),
);

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
