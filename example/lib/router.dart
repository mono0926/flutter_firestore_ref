import 'package:example/pages/home_page.dart';
import 'package:example/pages/paging_page/paging_page.dart';
import 'package:example/pages/user_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recase/recase.dart';

import 'util/util.dart';

typedef WidgetPageBuilder = Widget Function();

final router = Provider((_) => Router());

class Router {
  static const root = '/';

  final _routes = <String, WidgetPageBuilder>{
    root: () => const HomePage(),
    UserCounterPage.routeName: () => const UserCounterPage(),
    PagingPage.routeName: () => const PagingPage(),
  };
  final _modalRoutes = <String, WidgetPageBuilder>{};

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    logger.info(settings.name);
    var pageBuilder = _routes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (context) => pageBuilder!(),
        settings: settings,
      );
    }

    pageBuilder = _modalRoutes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (context) => pageBuilder!(),
        settings: settings,
        fullscreenDialog: true,
      );
    }

    assert(false, 'unexpected settings: $settings');
    return null;
  }
}

String pascalCaseFromRouteName(String name) => name.substring(1).pascalCase;

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
