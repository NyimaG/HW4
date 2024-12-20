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
    apiKey: 'AIzaSyDTkgmiaWT_hMrFJdGemdUmcG9H86YmLVA',
    appId: '1:613699566925:web:de56937ca7e47d2f9b0b04',
    messagingSenderId: '613699566925',
    projectId: 'chatboard-50fc0',
    authDomain: 'chatboard-50fc0.firebaseapp.com',
    storageBucket: 'chatboard-50fc0.firebasestorage.app',
    measurementId: 'G-E6GRVZGLPF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTVolVbbHI7OQuGxt6D6qF9rGCxeMvgQc',
    appId: '1:613699566925:android:aa05eec446e692be9b0b04',
    messagingSenderId: '613699566925',
    projectId: 'chatboard-50fc0',
    storageBucket: 'chatboard-50fc0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtgObT45KiGUhPiT89B6n6ktWd4dVYrAI',
    appId: '1:613699566925:ios:292c2ce5b5ad173d9b0b04',
    messagingSenderId: '613699566925',
    projectId: 'chatboard-50fc0',
    storageBucket: 'chatboard-50fc0.firebasestorage.app',
    iosBundleId: 'com.example.hw4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtgObT45KiGUhPiT89B6n6ktWd4dVYrAI',
    appId: '1:613699566925:ios:292c2ce5b5ad173d9b0b04',
    messagingSenderId: '613699566925',
    projectId: 'chatboard-50fc0',
    storageBucket: 'chatboard-50fc0.firebasestorage.app',
    iosBundleId: 'com.example.hw4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTkgmiaWT_hMrFJdGemdUmcG9H86YmLVA',
    appId: '1:613699566925:web:51d5aa4663e37df49b0b04',
    messagingSenderId: '613699566925',
    projectId: 'chatboard-50fc0',
    authDomain: 'chatboard-50fc0.firebaseapp.com',
    storageBucket: 'chatboard-50fc0.firebasestorage.app',
    measurementId: 'G-LTGPDD8YBK',
  );
}
