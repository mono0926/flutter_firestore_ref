import 'package:example/model/service/authenticator.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'run.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.select((Authenticator a) => a.user == null)
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp(
            title: context.select((AppInfo info) => info.title),
            home: HomePage.wrapped(),
          );
  }
}
