import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
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
  // TODO: https://github.com/FirebaseExtended/flutterfire/issues/4948#issuecomment-779636797
  else {
    FirebaseFirestore.instance.settings = const Settings();
  }

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
