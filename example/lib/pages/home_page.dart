import 'package:example/app.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(appInfo).title),
      ),
      body: ListView(
        children: PageInfo.all.map((info) {
          final routeName = info.routeName;
          return ListTile(
            title: Text(pascalCaseFromRouteName(routeName)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => GoRouter.of(context).goNamed(routeName),
          );
        }).toList(),
      ),
    );
  }
}
