import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/service/service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureFirestore(persistenceEnabled: true);
  runApp(
    MultiProvider(
      providers: [
        Provider(builder: (context) => AppInfo()),
        ChangeNotifierProvider(
          builder: (context) => Authenticator()..signInAnonymously(),
        ),
      ],
      child: App(),
    ),
  );
}

class AppInfo {
  String get title => 'Firebase Counter';
}
