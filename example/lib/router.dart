import 'package:example/pages/home_page.dart';
import 'package:example/pages/paging_page/paging_page.dart';
import 'package:example/pages/user_counter_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:recase/recase.dart';

typedef WidgetPageBuilder = Widget Function();

final routerProvider = Provider(
  (_) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            path: 'user-counter',
            name: UserCounterPage.routeName,
            builder: (_, __) => const UserCounterPage(),
          ),
          GoRoute(
            path: 'paging',
            name: PagingPage.routeName,
            builder: (_, __) => const PagingPage(),
          ),
        ],
      ),
    ],
    navigatorBuilder: (_, __, child) => GoRouterLocationButton(
      // ignore: avoid_redundant_argument_values
      visible: kDebugMode,
      child: child,
    ),
  ),
);

String pascalCaseFromRouteName(String name) => name.pascalCase;

@immutable
class PageInfo {
  const PageInfo({
    required this.routeName,
  });

  final String routeName;

  static const all = [
    PageInfo(routeName: UserCounterPage.routeName),
    PageInfo(routeName: PagingPage.routeName),
  ];
}
