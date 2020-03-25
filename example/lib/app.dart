import 'package:example/main.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: context.select((AppInfo info) => info.title),
      home: HomePage.wrapped(),
    );
  }
}
