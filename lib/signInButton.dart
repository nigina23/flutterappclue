import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappclue/auth_page.dart';
import 'package:flutterappclue/login_screen.dart';
import 'package:flutterappclue/main_homepage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot){

          if(snapshot.hasData){
            return  MainHomePage();
          }else{
            return AuthPage();
          }
        },
      ),
    );
  }
}
