import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'paging_page_controller.dart';

class const PagingPage({super.key}) extends ConsumerWidget {
  static const routeName = 'paging';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onPressed: () => ref.read(pagingDocsModifier).addDocs(10),
        label: const Text('10 DATA'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(ref.watch(pagingPageInfoProvider)),
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

class const _ListView() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pagingController);
    final docs = ref.watch(documentsProvider).value ?? [];
    final count = ref.watch(pagingDocsLengthForWidgetProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        if (index >= docs.length) {
          controller.loadMore();
          return const ListTile(
            title: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        final doc = docs[index];
        return ListTile(
          title: Text('${doc.entity!.count}'),
          trailing: IconButton(
            color: colorScheme.secondary,
            icon: const Icon(Icons.add),
            onPressed: () => ref.read(pagingDocsModifier).increment(doc: doc),
          ),
        );
      },
    );
  }
}

class const _DropdownButton() extends ConsumerWidget {
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
        ref.read(pagingDocsModifier).deleteAll();
      },
    );
  }
}
