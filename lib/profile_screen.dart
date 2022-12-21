import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;
  File? image;
  String imageUrl = "";
  String urlString = "";

  @override
  void initState() {
    super.initState();
    getUrl();
  }

  Future pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source); //bild picken
    if (image == null) return;
    String uniqueFileName = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); //bildname nach datum speichern
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = await referenceRoot.child('image');
    Reference referenceImageToUpload =
        await referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      setState(() async {
        imageUrl = await referenceImageToUpload.getDownloadURL();
        final usersRef = FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email);
        final profilePicUml = {"profilePicUrl": imageUrl};
        await usersRef.set(profilePicUml, SetOptions(merge: true));
        setState(() {
          urlString = imageUrl;
        });
      });
    } on PlatformException catch (e) {
    }
  }

  Future addUserImage(String imageUrl) async {
    await FirebaseFirestore.instance.collection('userImage').add({
      'userImageUrl': imageUrl,
    });
  }

  Future getUrl() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          urlString = data['profilePicUrl'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );

    print("passiert hier was");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              urlString.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                      urlString,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress){
                      if (loadingProgress == null){
                        return child;
                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },))
                  : const FlutterLogo(
                      size: 160,
                    ),
              const SizedBox(height: 24),

              buildButton(
                  title: "Bild aus der Galerie",
                  icon: Icons.image_outlined,
                  onClicked: () => pickImage(ImageSource.gallery)),
              const SizedBox(height: 24),

              buildButton(
                  title: "Mache ein Bild",
                  icon: Icons.camera_alt_outlined,
                  onClicked: () => pickImage(ImageSource.camera)),
              const SizedBox(height: 24),
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Color(0xFFB0C4DE),
                child: Text('Abmelden'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      GestureDetector(
        onTap: onClicked,
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Color(0xFFB0C4DE)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 16),
                Text(title),
              ],
            ),
          ),
        ),
      );
}
