import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/make_or_edit_card.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';


  class GroupAndEventsCards extends StatefulWidget {

  @override
  State<GroupAndEventsCards> createState() => _GroupAndEventsCardsState();
  }

  class _GroupAndEventsCardsState extends State<GroupAndEventsCards> {

  List<Widget> eventsListWidget(AsyncSnapshot snapshot){
    return snapshot.data.docs.map<Widget>((docs){

      String documentId = docs.id.toString();
      String user = "124";
      String resultUid = documentId.substring(0, documentId.indexOf('+'));



      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(docs['title'],),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(docs['description'],),
            ),
            //  final user = FirebaseAuth.instance.currentUser!.uid;
     (user == resultUid) ?
                  TextButton(onPressed: (){
                    showCupertinoDialog(
                      context: context,
                      builder: (context) =>  CupertinoAlertDialog(
                        title: Text("This Will Completely Delete Your Event"),
                        actions: [
                          CupertinoDialogAction(child: Text("Accept"),
                            onPressed: (){
                            FirebaseStorage.instance.ref().child(documentId).delete();
                          FirebaseFirestore.instance.collection('Events').doc(documentId).delete();
                          Navigator.pop(context);
                          },
                    ),
                          CupertinoDialogAction(
                            child: Text("Cancel"), onPressed: (){Navigator.pop(context);},),
                        ],
                      ),
                    );

                  }, child: Text("Delete")) :
      TextButton(onPressed: (){
        FirebaseFirestore.instance.collection('Events').doc(documentId).update({"JoinedUsers": FieldValue.arrayUnion([user])});
      }, child: Text("Join"))

            /*:
         TextButton(onPressed: () {
           FirebaseFirestore.instance.collection('Events')
               .doc(documentId)
               .update({"JoinedUsers": FieldValue.arrayRemove([user])});
           setState(() {});
         }, child: Text("Joined")),*/



          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Events').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        return  (!snapshot.hasData)? Center(child: CircularProgressIndicator()) : (snapshot.data.docs.isEmpty) ? Center(child: Text('Be The First to Post an Event in your Area!'))
            : ListView(
          children: eventsListWidget(snapshot),
        );
      },
    );
  }
}