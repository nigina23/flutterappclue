import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Track extends StatefulWidget {
  const Track({Key? key}) : super(key: key);

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  DateTime today = new DateTime.now();
  bool cklicked = false;


  @override
  Widget build(BuildContext context) {
    List<String> pictures = ["assets/blutung.png","assets/allesGut.png","assets/schöneHaut.png","assets/stimmungsSchwankung.png","assets/unterBauchSchmerzen.png","assets/regelSchmerzen.png"];

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           GestureDetector(
               child: DecoratedBox(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[300]),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("${today.day.toString()}.${today.month.toString()}.${today.year.toString()}",
                     textAlign: TextAlign.center,
                     style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 ),
               ),
                  onTap: () async{
                 DateTime? date = await showDatePicker(context: context, initialDate: today, firstDate: DateTime(2020)
                     , lastDate: DateTime.now(),
                 );
                  if(date==null) {
                    return;
                  } else{
                    setState(() {
                      today = date;
                    });
                  }

                  },
                ),

           Text("Was ist heute passiert ?"),
           Expanded(
             child: Container(
               padding: const EdgeInsets.only(
                 top: 30
               ),
               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(50)
                 ,topRight: Radius.circular(50)),
               ),
               child: GridView.builder(
                 itemCount: pictures.length,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 10,
                   mainAxisSpacing: 10,
                 ),
                 itemBuilder: (context, index) {
                   return Container(
                     alignment: Alignment.center,
                     decoration: const BoxDecoration(
                         color: Color(0xFFB0C4DE),
                         shape: BoxShape.circle,
                      ),
                     child: IconButton(
                       icon: Image.asset(
                         pictures[index],
                         width: 300,
                         height: 300,
                       ),
                       iconSize: 60,
                       onPressed: () {sentDayToFirebase();},
                     ),
                   );
                 },
               ),
             ),
           )
         ],
        ),
      ),
    );
  }
  Future sentDayToFirebase() async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email).update({'selectedDates':FieldValue.arrayUnion([today])});
  }
}
