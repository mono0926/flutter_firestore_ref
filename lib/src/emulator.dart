import 'dart:io';

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

final String emulatorDomain =
    (!kIsWeb && Platform.isAndroid) ? '10.0.2.2' : 'localhost';

const defaultEmulatorPort = 8080;

void useFirestoreEmulator({int port = defaultEmulatorPort}) {
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
    host: '$emulatorDomain:$port',
    sslEnabled: false,
  );
}
