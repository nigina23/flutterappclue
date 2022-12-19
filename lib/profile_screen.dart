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
    // TODO: implement initState
    super.initState();
    getUrl();
  }

  Future pickImage(ImageSource source) async {
    //try {
    XFile? image = await ImagePicker().pickImage(source: source); //bild picken
    print(image!.path);
    if (image == null) return;
    String uniqueFileName = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); //bildname nach datum speichern
    Reference referenceRoot = FirebaseStorage.instance.ref();
    print(referenceRoot.toString());
    Reference referenceDirImages = await referenceRoot.child('image');
    Reference referenceImageToUpload =
        await referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      setState(() async {
        imageUrl = await referenceImageToUpload.getDownloadURL();
        print('hier ist die imageurl$imageUrl');

        final usersRef = FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email);
        final profilePicUml = {"profilePicUrl": imageUrl};
        await usersRef.set(profilePicUml, SetOptions(merge: true));
        setState(() {
          urlString = imageUrl;
        });
      });
      //addUserImage(imageUrl.trim());
    } on PlatformException catch (e) {
      // TODO
      print(e.message);
    }
    ;
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
        child: Column(
          children: [
            urlString.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                    urlString,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ))
                : FlutterLogo(
                    size: 160,
                  ),

            buildButton(
                title: "Pick Gallery",
                icon: Icons.image_outlined,
                onClicked: () => pickImage(ImageSource.gallery)),
            const SizedBox(height: 24),
            buildButton(
                title: "Take a Picture",
                icon: Icons.camera_alt_outlined,
                onClicked: () => pickImage(ImageSource.camera)),
            const SizedBox(height: 24),
            MaterialButton(
              onPressed: () {
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

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(56),
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: TextStyle(fontSize: 20),
          ),
          onPressed: onClicked,
          child: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 16),
              Text(title),
            ],
          ));
}
