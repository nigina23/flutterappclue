import 'package:flutter/material.dart';
import 'package:flutterappclue/HelpScreen.dart';
import 'package:flutterappclue/signInButton.dart';
import 'package:firebase_core/firebase_core.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

