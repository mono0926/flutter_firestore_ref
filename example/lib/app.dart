import 'package:example/model/service/authenticator.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return useProvider(
            authenticator.select((Authenticator a) => a.user == null))
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp(
            title: useProvider(appInfo).title,
            onGenerateRoute: useProvider(router).onGenerateRoute,
            theme: ThemeData.from(
              colorScheme: const ColorScheme.light(),
            ).copyWith(
              dividerColor: Colors.black54,
            ),
            darkTheme: ThemeData.from(
              colorScheme: const ColorScheme.dark(),
            ),
          );
  }
}

final appInfo = Provider((_) => AppInfo());

class AppInfo {
  String get title => 'firestore_ref example';
}
