import 'package:example/router.dart';
import 'package:example/run.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.select((AppInfo info) => info.title)),
      ),
      body: ListView(
        children: PageInfo.all.map((info) {
          final routeName = info.routeName;
          return ListTile(
            title: Text(pascalCaseFromRouteName(routeName)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(routeName),
          );
        }).toList(),
      ),
    );
  }
}
