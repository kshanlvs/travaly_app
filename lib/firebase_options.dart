import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else {
      return windows;
    }
  }

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: dotenv.get('ANDROID_API_KEY'),
        appId: dotenv.get('ANDROID_APP_ID'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: dotenv.get('FIREBASE_PROJECT_ID'),
        storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: dotenv.get('IOS_API_KEY'),
        appId: dotenv.get('IOS_APP_ID'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: dotenv.get('FIREBASE_PROJECT_ID'),
        storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
        iosBundleId: dotenv.get('IOS_BUNDLE_ID'),
      );

  static FirebaseOptions get windows => FirebaseOptions(
        apiKey: dotenv.get('WEB_API_KEY'),
        appId: dotenv.get('WEB_APP_ID'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: dotenv.get('FIREBASE_PROJECT_ID'),
        authDomain: dotenv.get('WEB_AUTH_DOMAIN'),
        storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
      );
}
