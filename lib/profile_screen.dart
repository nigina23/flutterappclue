import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;


  File? image;

  Future pickImage(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }
  Future<File> saveImagePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            image != null ? ClipOval(child: Image.file(
              image!,
              width: 160,
              height: 160,
              fit: BoxFit.cover,)
            ):const FlutterLogo(size: 160),
            MaterialButton(onPressed:(){
              FirebaseAuth.instance.signOut();
            },
              color: Colors.deepPurple,
              child: Text('Abmelden'),
            ),
            buildButton(
                title: "Pick Gallery",
                icon: Icons.image_outlined,
                onClicked:() => pickImage(ImageSource.gallery)
            ),
            const SizedBox(height:24),
            buildButton(
                title: "Take a Picture",
                icon: Icons.camera_alt_outlined,
                onClicked:() => pickImage(ImageSource.camera)
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(56),
        primary:Colors.white,
        onPrimary: Colors.black,
        textStyle: TextStyle(fontSize: 20),),
      onPressed: onClicked,
      child : Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(title),],));
}