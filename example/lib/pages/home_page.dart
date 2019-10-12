import 'package:example/main.dart';
import 'package:example/model/service/service.dart';
import 'package:example/model/service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Provider.of<AppInfo>(context).title)),
      body: Column(
        children: [
          const _AccountStatus(),
          ChangeNotifierProxyProvider<Authenticator, UserNotifier>(
            builder: (context, authenticator, previous) =>
                UserNotifier.fromId(authenticator.user?.uid),
            child: const _MyCounter(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _AccountStatus extends StatelessWidget {
  const _AccountStatus({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authenticator = Provider.of<Authenticator>(context);

    return ListTile(
      title: const Text('User ID'),
      subtitle: Text(
        authenticator.user?.uid ?? '0',
      ),
    );
  }
}

class _MyCounter extends StatelessWidget {
  const _MyCounter({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('My Count'),
      subtitle: Text(Provider.of<UserNotifier>(context).count.toString()),
      trailing: IconButton(
        color: Theme.of(context).primaryColor,
        icon: Icon(Icons.add),
        onPressed: () {
          Provider.of<UserNotifier>(context, listen: false).increment();
        },
      ),
    );
  }
}
