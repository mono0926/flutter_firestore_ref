import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/service/service.dart';
import 'util/util.dart';

void run({bool isEmulator = false}) {
  logger.fine('start');
  WidgetsFlutterBinding.ensureInitialized();
  // For web
  Firestore.instance.settings(persistenceEnabled: true);
  // TODO(mono): Emulator対応
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
