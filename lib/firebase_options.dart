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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBl7xVJtO-tTaSHjNyJ_NPE2474DVi22vw',
    appId: '1:1043110472304:web:9391139016f7a50f4262b5',
    messagingSenderId: '1043110472304',
    projectId: 'my-cat-coffee-bar',
    authDomain: 'my-cat-coffee-bar.firebaseapp.com',
    storageBucket: 'my-cat-coffee-bar.firebasestorage.app',
    measurementId: 'G-0X0LKPLXRF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTzhmT-m341bIsskXBIqcQKqI4t5QMlJ8',
    appId: '1:1043110472304:android:73e8565c9662180b4262b5',
    messagingSenderId: '1043110472304',
    projectId: 'my-cat-coffee-bar',
    storageBucket: 'my-cat-coffee-bar.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUESs1XSRNgEtZmKuT3c6GvKmau7Yvw_A',
    appId: '1:1043110472304:ios:40993563512dd1674262b5',
    messagingSenderId: '1043110472304',
    projectId: 'my-cat-coffee-bar',
    storageBucket: 'my-cat-coffee-bar.firebasestorage.app',
    iosBundleId: 'com.example.flutterMycatcoffeebarP1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBl7xVJtO-tTaSHjNyJ_NPE2474DVi22vw',
    appId: '1:1043110472304:web:c0667c7185b6dcb04262b5',
    messagingSenderId: '1043110472304',
    projectId: 'my-cat-coffee-bar',
    authDomain: 'my-cat-coffee-bar.firebaseapp.com',
    storageBucket: 'my-cat-coffee-bar.firebasestorage.app',
    measurementId: 'G-JT8K2LXNYD',
  );
}
