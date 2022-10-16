import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user= FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
            child: Column(
              children: [
                Profile(
                  imageUrl: 'https://images.unsplash.com/photo-1598618356794-eb1720430eb4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  name: 'Nigina Isam',
                  website: 'niginaspage',
                  designation: 'dkjcbjfhvb',
                  email: user.email!,
                  phone_number: '+491776999203',
                ),
                MaterialButton(onPressed:(){
                FirebaseAuth.instance.signOut();
                },
                  color: Colors.deepPurple,
                  child: Text('Abmelden'),
                ),
              ],
            ),
      ),
    );
  }
}