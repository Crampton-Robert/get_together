import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';


class EventsCards extends StatefulWidget {
  @override
  State<EventsCards> createState() => _EventsCardsState();
}

class _EventsCardsState extends State<EventsCards> {
  List<Widget> eventsListWidget(AsyncSnapshot snapshot){

    return snapshot.data.docs.map<Widget>((docs) {

      // Variables
      String documentId = docs.id.toString();
      String user = "124";
      String resultUid = documentId.substring(0, documentId.indexOf('+'));
      List joined = docs["joinedUsers"];
      num list_length = joined.length;
      num true_list_length = list_length-1;
      String peopleHave_Or_personHas;

      //Logic
      if(true_list_length == 1){
        peopleHave_Or_personHas = "Person Has";
      }else{
        peopleHave_Or_personHas = "People Have";
      }

      data(String addOrRemove, user){

        FieldValue? myArray;
        var documentReference =  FirebaseFirestore.instance.collection('Events').doc(documentId);
        var arrayName = "joinedUsers";


        if (addOrRemove == "remove") {
          myArray = FieldValue.arrayRemove([user]);
          documentReference.update({"$arrayName": myArray});
        } else if (addOrRemove == "add") {
          myArray = FieldValue.arrayUnion([user]);
          documentReference.update({"$arrayName": myArray});
        } else if (addOrRemove == 'delete') {
        documentReference.delete();
        }
      }


      //View
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

            Padding(
              padding: EdgeInsets.all(5),
              child:Align(
                alignment: AlignmentDirectional.centerEnd,
                child://  final user = FirebaseAuth.instance.currentUser!.uid;
                (user == resultUid) ?
                TextButton(onPressed: (){
                  showCupertinoDialog(
                    context: context,
                    builder: (context) =>  CupertinoAlertDialog(
                      title: Text("This Will Completely Delete Your Event"),
                      actions: [
                        CupertinoDialogAction(child: Text("Accept"),
                          onPressed: (){
                          data("delete", user);
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text("Cancel"), onPressed: (){Navigator.pop(context);},),
                      ],
                    ),
                  );

                }, child: Text("Delete")) : (joined.contains(user) != true) ?

                TextButton(onPressed: (){ data('add', user); }, child: Text("Join")) :

                TextButton(onPressed: () {
                  data("remove", user);
                }, child: Text("Leave Event")),

              ),
            ),
            Padding(padding: EdgeInsets.all(25), child: Text(true_list_length.toString()+" $peopleHave_Or_personHas Joined This Event"),),



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