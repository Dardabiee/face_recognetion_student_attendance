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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDhZQQW3LOLexfC9iSxuY19szhSEfshFOY',
    appId: '1:119453243258:web:4fe59a8fdc8f56d6afa8c3',
    messagingSenderId: '119453243258',
    projectId: 'my-students-absen',
    authDomain: 'my-students-absen.firebaseapp.com',
    storageBucket: 'my-students-absen.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2xtPLd2n22q7WRrj5w0EQcecAuVMaAHM',
    appId: '1:119453243258:android:002f65c3c1a3a80cafa8c3',
    messagingSenderId: '119453243258',
    projectId: 'my-students-absen',
    storageBucket: 'my-students-absen.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbhqG6-k8iRyrCthnIClDOlbi25DxCgVY',
    appId: '1:119453243258:ios:c3f5fee87343377aafa8c3',
    messagingSenderId: '119453243258',
    projectId: 'my-students-absen',
    storageBucket: 'my-students-absen.firebasestorage.app',
    iosBundleId: 'com.example.studentAttendanceWithMlkit',
  );
}
