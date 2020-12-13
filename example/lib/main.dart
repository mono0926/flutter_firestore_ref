import 'package:cloud_functions/cloud_functions.dart';
import 'package:example/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;

import 'app.dart';
import 'model/service/service.dart';
import 'util/util.dart';

Future<void> main() async {
  const isEmulator = bool.fromEnvironment('IS_EMULATOR');
  logger.fine('start(isEmulator: $isEmulator)');

  firestoreOperationCounter.enabled = true;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (isEmulator) {
    FirebaseFunctions.instance.useFunctionsEmulator(
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
