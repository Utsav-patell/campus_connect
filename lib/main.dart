import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // QUIZ : What is wrong here
  await Firebase.initializeApp()
      .then((_) {
        log('Firebase initialization successful');
      })
      .catchError((error) {
        // Handle initialization error
        log('Firebase initialization error: $error');
      });

  runApp(const App());
}
