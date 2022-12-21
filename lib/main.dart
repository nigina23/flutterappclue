import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterappclue/help_screen.dart';
import 'package:flutterappclue/signInButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      print('This is an error in Flutter SDK code: ${details.exception}');
    };
    await Firebase.initializeApp();
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    print('This is an error somewhere in Dart code: $error');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Clue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de')
      ],
      routes: {
        '/Help': (context) => HelpScreen(),
      },
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFB0C4DE),
      )),
      home: MainPage(),
    );
  }
}
