import 'package:example/main.dart';
import 'package:example/model/service/service.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

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
            initialBuilder: null,
            builder: (context, authenticator, previous) =>
                UserNotifier.fromId(authenticator.user?.uid),
            child: const _MyCounter(),
          ),
          const Divider(),
          Expanded(
            child: ChangeNotifierProvider(
              builder: (context) => UsersNotifier(),
              child: const _Users(),
            ),
          ),
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

class _Users extends StatelessWidget {
  const _Users({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authenticator = Provider.of<Authenticator>(context);
    final notifier = Provider.of<UsersNotifier>(context);
    final docs = notifier.userDocs;
    return ListView.builder(
      itemBuilder: (context, index) {
        final doc = docs[index];
        return Container(
          key: ValueKey(doc.id),
          color: authenticator.user?.uid == doc.id ? Colors.green[100] : null,
          child: ListTile(
            title: Text(doc.id),
            subtitle: Text('count: ${doc.entity.count}'),
          ),
        );
      },
      itemCount: docs.length,
    );
  }
}
