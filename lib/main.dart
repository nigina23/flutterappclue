import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappclue/HelpScreen.dart';
import 'package:flutterappclue/signInButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Clue';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes:{
        '/Help': (context) => HelpScreen(),},
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF9C25F4),
          )),

      home:  MainPage(),
    );
  }
}

