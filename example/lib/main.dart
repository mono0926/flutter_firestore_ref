import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/service/service.dart';
import 'util/util.dart';

void main() {
  logger.fine('start');
  WidgetsFlutterBinding.ensureInitialized();
  configureFirestore(persistenceEnabled: true);
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AppInfo()),
        ChangeNotifierProvider(
          create: (context) => Authenticator()..signInAnonymously(),
        ),
      ],
      child: App(),
    ),
  );
}

class AppInfo {
  String get title => 'Firebase Counter';
}
