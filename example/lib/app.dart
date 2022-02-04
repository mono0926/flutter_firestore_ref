import 'package:example/model/service/authenticator.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(signInAnonymouslyProvider);
    final isSignedIn = ref.watch(isSignedInProvider).value ?? false;
    return !isSignedIn
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp(
            title: ref.watch(appInfo).title,
            onGenerateRoute: ref.watch(router).onGenerateRoute,
            theme: ThemeData(
              colorSchemeSeed: Colors.green,
              useMaterial3: true,
            ).copyWith(
              dividerColor: Colors.black54,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: Colors.green,
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
          );
  }
}

final appInfo = Provider((_) => AppInfo());

class AppInfo {
  String get title => 'firestore_ref example';
}
