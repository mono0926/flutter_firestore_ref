// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjXjl92rq2LrMpJAOV_LYnX-4p2sqlcHk',
    appId: '1:411503049546:web:3f41ceee03b1020038dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    authDomain: 'fir-fir-mono.firebaseapp.com',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    measurementId: 'G-Z4BLYS3KF7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC68jwLKzJ8E61j40yCwRQeGeVIm4nO0kk',
    appId: '1:411503049546:android:1d02260d28cada9c38dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1cRlErkR2IFkaHdfhjFPARNQC02XCefU',
    appId: '1:411503049546:ios:2fd66156364836ac38dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    androidClientId: '411503049546-fdeqtjv1jl7cjkkvn8sgi02limetqjh5.apps.googleusercontent.com',
    iosClientId: '411503049546-q5vegmho0pa0gnig8rmo92n04scr950i.apps.googleusercontent.com',
    iosBundleId: 'com.example.example',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1cRlErkR2IFkaHdfhjFPARNQC02XCefU',
    appId: '1:411503049546:ios:2fd66156364836ac38dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    androidClientId: '411503049546-fdeqtjv1jl7cjkkvn8sgi02limetqjh5.apps.googleusercontent.com',
    iosClientId: '411503049546-q5vegmho0pa0gnig8rmo92n04scr950i.apps.googleusercontent.com',
    iosBundleId: 'com.example.example',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjXjl92rq2LrMpJAOV_LYnX-4p2sqlcHk',
    appId: '1:411503049546:web:3f41ceee03b1020038dfb3',
    messagingSenderId: '411503049546',
    projectId: 'fir-fir-mono',
    authDomain: 'fir-fir-mono.firebaseapp.com',
    databaseURL: 'https://fir-fir-mono.firebaseio.com',
    storageBucket: 'fir-fir-mono.appspot.com',
    measurementId: 'G-Z4BLYS3KF7',
  );
}
