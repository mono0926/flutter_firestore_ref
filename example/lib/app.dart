import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Provider.of<AppInfo>(context).title,
      home: const HomePage(),
    );
  }
}
