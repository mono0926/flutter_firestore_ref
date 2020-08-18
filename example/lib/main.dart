import 'package:cloud_functions/cloud_functions.dart';
import 'package:example/router.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;

import 'app.dart';
import 'model/service/service.dart';
import 'util/util.dart';

Future<void> main() async {
  const isEmulator = bool.fromEnvironment('IS_EMULATOR');
  logger.fine('start(isEmulator: $isEmulator)');

  recordFirestoreOperationCount = true;

  WidgetsFlutterBinding.ensureInitialized();

  if (isEmulator) {
    CloudFunctions.instance.useFunctionsEmulator(
      origin: 'http://$emulatorDomain:5001',
    );
    await useFirestoreEmulator();
  } else if (kIsWeb) {
    await Firestore.instance.settings(persistenceEnabled: true);
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
