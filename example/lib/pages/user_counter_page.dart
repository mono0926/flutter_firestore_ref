import 'package:cloud_functions/cloud_functions.dart';
import 'package:example/model/service/service.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCounterPage extends ConsumerWidget {
  const UserCounterPage({Key? key}) : super(key: key);

  static const routeName = 'user_counter';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateType = ref.watch(selectedUpdateType);
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
              onValueChanged: (type) => ref
                  .read(selectedUpdateType.notifier)
                  .update((state) => type!),
              groupValue: updateType,
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

class _DropdownButton extends ConsumerWidget {
  const _DropdownButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        ref.read(usersDeleter)();
      },
    );
  }
}

class _AccountStatus extends ConsumerWidget {
  const _AccountStatus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('User ID'),
      subtitle: Text(
        ref.watch(userIdProvider.select((id) => id.value ?? '-')),
      ),
    );
  }
}

class _MyCounter extends ConsumerWidget {
  const _MyCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('My Count'),
      subtitle: Text('${ref.watch(myCountProvider)}'),
      trailing: IconButton(
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        onPressed: () async {
          ref.read(countIncrementer)();
          // 適当にどこかで雑に呼びたかっただけでサンプルとは関係なし(無視してください)
          final result = await FirebaseFunctions.instance
              .httpsCallable('now')
              .call<JsonMap>();
          logger.info(result.data);
        },
      ),
    );
  }
}

class _Users extends ConsumerWidget {
  const _Users({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(userDocsProvider).value ?? [];
    final myId = ref.watch(userIdProvider).value;
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

final selectedUpdateType = StateProvider((ref) => UpdateType.add);

enum UpdateType {
  add,
  increment,
  batch,
  transaction,
}
