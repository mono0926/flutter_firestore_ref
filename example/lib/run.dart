import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/service/service.dart';
import 'util/util.dart';

Future<void> run({bool isEmulator = false}) async {
  logger.fine('start(isEmulator: $isEmulator)');
  WidgetsFlutterBinding.ensureInitialized();

  if (isEmulator) {
    final domain = (!kIsWeb && Platform.isAndroid) ? '10.0.2.2' : 'localhost';
    CloudFunctions.instance.useFunctionsEmulator(origin: 'http://$domain:5001');
    await Firestore.instance.settings(
      persistenceEnabled: false,
      host: '$domain:8080',
      sslEnabled: false,
    );
  } else if (kIsWeb) {
    await Firestore.instance.settings(persistenceEnabled: true);
  }

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
