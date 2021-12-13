// import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    const localhost = 'localhost';
    FirebaseFunctions.instance.useFunctionsEmulator(localhost, 5001);
    FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
    await Future.wait(
      [
        FirebaseAuth.instance.useAuthEmulator(localhost, 9099),
        FirebaseStorage.instance.useStorageEmulator(localhost, 9199),
      ],
    );
  } else if (kIsWeb) {
    await FirebaseFirestore.instance.enablePersistence(
      const PersistenceSettings(synchronizeTabs: true),
    );
  }

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
