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
    apiKey: 'AIzaSyDT3sVlO6eA8el4NaMyTLK1l7BD48JHu5c',
    appId: '1:709625077725:web:1bc7583847764e7dc3a034',
    messagingSenderId: '709625077725',
    projectId: 'notes-d8be0',
    authDomain: 'notes-d8be0.firebaseapp.com',
    databaseURL: 'https://notes-d8be0-default-rtdb.firebaseio.com',
    storageBucket: 'notes-d8be0.appspot.com',
    measurementId: 'G-FV6KVYX1N5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2AfeeN43MHuXw6qDHw68D8XwY3qKP-_0',
    appId: '1:709625077725:android:f01e87ee043ec52fc3a034',
    messagingSenderId: '709625077725',
    projectId: 'notes-d8be0',
    databaseURL: 'https://notes-d8be0-default-rtdb.firebaseio.com',
    storageBucket: 'notes-d8be0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdEPakqEnQNtRVNb4UEMphKaFoC2vwlzc',
    appId: '1:709625077725:ios:635607e2afb00d99c3a034',
    messagingSenderId: '709625077725',
    projectId: 'notes-d8be0',
    databaseURL: 'https://notes-d8be0-default-rtdb.firebaseio.com',
    storageBucket: 'notes-d8be0.appspot.com',
    iosClientId: '709625077725-npfl3e9hnd8gs0hih6k4kgd76fa8362o.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdEPakqEnQNtRVNb4UEMphKaFoC2vwlzc',
    appId: '1:709625077725:ios:635607e2afb00d99c3a034',
    messagingSenderId: '709625077725',
    projectId: 'notes-d8be0',
    databaseURL: 'https://notes-d8be0-default-rtdb.firebaseio.com',
    storageBucket: 'notes-d8be0.appspot.com',
    iosClientId: '709625077725-npfl3e9hnd8gs0hih6k4kgd76fa8362o.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDT3sVlO6eA8el4NaMyTLK1l7BD48JHu5c',
    appId: '1:709625077725:web:98d080151187b3d1c3a034',
    messagingSenderId: '709625077725',
    projectId: 'notes-d8be0',
    authDomain: 'notes-d8be0.firebaseapp.com',
    databaseURL: 'https://notes-d8be0-default-rtdb.firebaseio.com',
    storageBucket: 'notes-d8be0.appspot.com',
    measurementId: 'G-8T75ZR63YH',
  );
}