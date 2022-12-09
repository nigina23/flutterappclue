import 'package:flutter/material.dart';
import 'package:flutterappclue/login_screen.dart';
import 'package:flutterappclue/register_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login page
  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(showRegisterPage: togglePage);
    }else{
      return RegisterScreen(showLoginPage: togglePage);
    }
  }
}
