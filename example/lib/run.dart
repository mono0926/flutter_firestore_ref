import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/service/service.dart';
import 'router.dart';
import 'util/util.dart';

Future<void> run({bool isEmulator = false}) async {
  logger.fine('start(isEmulator: $isEmulator)');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (isEmulator) {
    CloudFunctions.instance.useFunctionsEmulator(
      origin: 'http://$emulatorDomain:5001',
    );
    useFirestoreEmulator();
  } else if (kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AppInfo()),
        Provider(create: (context) => Router()),
        ChangeNotifierProvider(
          create: (context) => Authenticator()..signInAnonymously(),
        ),
      ],
      child: App(),
    ),
  );
}

class AppInfo {
  String get title => 'firestore_ref example';
}
