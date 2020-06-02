import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'paging_page_controller.dart';

class PagingPage extends StatelessWidget {
  const PagingPage._({Key key}) : super(key: key);

  static const routeName = '/paging_page';

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        PagingPageController.provider(),
      ],
      child: const PagingPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PagingPageController>();
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
                context.select((PagingPageState s) => s.info),
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

class _ListView extends StatelessWidget {
  const _ListView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PagingPageController>();
    final docs = context.select((PagingPageState s) => s.docs);
    final count = context.select(
      (PagingPageState s) => docs.length + (s.hasMore ? 1 : 0),
    );
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
          title: Text('${doc.entity.count}'),
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

class _DropdownButton extends StatelessWidget {
  const _DropdownButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final controller = context.watch<PagingPageController>();
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
        controller.deleteAll();
      },
    );
  }
}
