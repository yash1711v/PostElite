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
    apiKey: 'AIzaSyB55JoGgl9C2qU5DYKQTdgTIxAYLY2yDu0',
    appId: '1:514183842715:web:69feedb3cfa0a7fdc8ef3e',
    messagingSenderId: '514183842715',
    projectId: 'sukanya-samriddhi-yojana-6e549',
    authDomain: 'sukanya-samriddhi-yojana-6e549.firebaseapp.com',
    storageBucket: 'sukanya-samriddhi-yojana-6e549.appspot.com',
    measurementId: 'G-PHZMKF50Q4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3Hj4xVQhshjmUam5m2hyqCnmJALrm3fU',
    appId: '1:514183842715:android:3edb36cf4d22e597c8ef3e',
    messagingSenderId: '514183842715',
    projectId: 'sukanya-samriddhi-yojana-6e549',
    storageBucket: 'sukanya-samriddhi-yojana-6e549.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqqpwIP4A6-Ucd7P990AMG60zMX29UJfg',
    appId: '1:514183842715:ios:e43efed27c42e4d1c8ef3e',
    messagingSenderId: '514183842715',
    projectId: 'sukanya-samriddhi-yojana-6e549',
    storageBucket: 'sukanya-samriddhi-yojana-6e549.appspot.com',
    iosBundleId: 'com.example.postElite',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqqpwIP4A6-Ucd7P990AMG60zMX29UJfg',
    appId: '1:514183842715:ios:e43efed27c42e4d1c8ef3e',
    messagingSenderId: '514183842715',
    projectId: 'sukanya-samriddhi-yojana-6e549',
    storageBucket: 'sukanya-samriddhi-yojana-6e549.appspot.com',
    iosBundleId: 'com.example.postElite',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB55JoGgl9C2qU5DYKQTdgTIxAYLY2yDu0',
    appId: '1:514183842715:web:9fbd2708d6849461c8ef3e',
    messagingSenderId: '514183842715',
    projectId: 'sukanya-samriddhi-yojana-6e549',
    authDomain: 'sukanya-samriddhi-yojana-6e549.firebaseapp.com',
    storageBucket: 'sukanya-samriddhi-yojana-6e549.appspot.com',
    measurementId: 'G-XLPYH2CZBM',
  );
}
