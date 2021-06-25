import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'paging_page_controller.dart';

class PagingPage extends ConsumerWidget {
  const PagingPage({Key? key}) : super(key: key);

  static const routeName = '/paging_page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pagingPageController.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pascalCaseFromRouteName(routeName),
        ),
        actions: const [
          _DropdownButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.addDocs(10),
        label: const Text('10 DATA'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(
                ref.watch(pagingPageController.select((s) => s.info)),
              ),
            ),
          ),
          const Divider(height: 0),
          const Expanded(
            child: _ListView(),
          ),
        ],
      ),
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pagingPageController.notifier);
    final docs = ref.watch(pagingPageController.select((s) => s.docs));
    final count = ref.watch(pagingPageController.select(
      (s) => docs.length + (s.hasMore ? 1 : 0),
    ));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        if (index >= docs.length) {
          if (index > 0) {
            controller.loadMore();
          }
          return const ListTile(
            title: Center(child: CircularProgressIndicator()),
          );
        }
        final doc = docs[index];
        return ListTile(
          title: Text('${doc.entity!.count}'),
          trailing: IconButton(
            color: colorScheme.primaryVariant,
            icon: const Icon(Icons.add),
            onPressed: () => controller.increment(doc: doc),
          ),
        );
      },
    );
  }
}

class _DropdownButton extends ConsumerWidget {
  const _DropdownButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final controller = ref.watch(pagingPageController.notifier);
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
        controller.deleteAll();
      },
    );
  }
}
