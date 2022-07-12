import 'package:example/model/service/authenticator.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(signInAnonymouslyProvider);
    final isSignedIn = ref.watch(isSignedInProvider).value ?? false;
    final router = ref.watch(routerProvider);
    return !isSignedIn
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp.router(
            title: ref.watch(appInfo).title,
            theme: lightTheme().copyWith(
              dividerColor: Colors.black54,
            ),
            darkTheme: darkTheme(),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
  }
}

final appInfo = Provider((_) => AppInfo());

class AppInfo {
  String get title => 'firestore_ref example';
}
