import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //text controller
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp () async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  bool passwordConfirmed() {
    if(_passwordController.text.trim()==_confirmPasswordController.text.trim()){
      return true;
    }else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9C25F4),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 100,
                ),
                const SizedBox(height: 20,),
                const Text("Registriere dich hier",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 30),),
                SizedBox(height: 20,),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                ),




                const SizedBox(height: 20,),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child:TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                // controlle des Passwords
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child:TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Confirm Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),

                //signing button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Color(0xFFf4a825),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text("Registrieren",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Schon a registriert? ",
                      style: TextStyle(
                        color: Color(0xFF3A0EA8),
                        fontWeight: FontWeight.bold,
                      ),),
                    GestureDetector(
                      onTap:widget.showLoginPage ,
                      child: Text("Hier einloggen",style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],

            ),
          ),

        ),
      ),
    );
  }
}
