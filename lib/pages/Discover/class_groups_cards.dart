import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/Groups/group_application.dart';
import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';


class GroupsCards extends StatefulWidget {

  @override
  State<GroupsCards> createState() => _GroupsCardsState();
}

class _GroupsCardsState extends State<GroupsCards> {

  List<Widget> eventsListWidget(AsyncSnapshot snapshot){
    return snapshot.data.docs.map<Widget>((docs) {

      String documentId = docs.id.toString();
      String user = "124";
      List requestedUsers = docs['requestedUsers'];
      List joined = docs["joinedUsers"];
      num list_length = joined.length;
      num true_list_length = list_length-1;
      String peopleHave_Or_personHas;


      if(true_list_length == 1){
        peopleHave_Or_personHas = "Person Has";
      }else{
        peopleHave_Or_personHas = "People Have";
      }


    data(String addOrRemove, user){

      FieldValue? myArray;

      var documentReference = FirebaseFirestore.instance.collection('Groups').doc(documentId);
      var arrayName = "joinedUsers";


      if (addOrRemove == "remove") {
      myArray = FieldValue.arrayRemove([user]);
      documentReference.update({"$arrayName": myArray});
      } else if (addOrRemove == "add") {
      myArray = FieldValue.arrayUnion([user]);
      documentReference.update({"$arrayName": myArray});
      } else if (addOrRemove == 'delete') {
      documentReference.delete();
      } else if (addOrRemove == 'requested'){
       documentReference.update({"$arrayName": FieldValue.arrayUnion([user])});
      }
      }

      return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
      children: [
      ListTile(
      title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
      Text(docs['title']),
      (docs["privacy"]) ? Row(children: [Text("Private Group (${docs['size']})"), Icon(Icons.lock), ],) : Row(children: [ Text("Public Group (${docs['size']})"), Icon(Icons.lock),],),
      ],),
      ),

      Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text(docs['description'],),
      ),





      Padding(
      padding: EdgeInsets.all(5),
      child:Align(
      alignment: AlignmentDirectional.centerEnd,
      child: (joined.contains(user) == true)
          ?
      TextButton(onPressed: () {data("remove", user);}, child: Text("Leave Group"))
          :
      (docs["privacy"] == false)
          ?
      TextButton(onPressed: (){data('add', user);}, child: Text("Join"))
          :
      (docs["application"] == true && requestedUsers.contains(user) == false) ?

      TextButton(onPressed: (){
        showCupertinoDialog(
            context: context,
            builder: (context) =>
                GroupApplication(
                    documentId: documentId,
                    questionOne: docs['questionOne'].toString(),
                    questionTwo: docs['questionTwo'].toString(),
                    questionThree: docs['questionThree'].toString(),
                    leader: docs['leader'].toString(),
                    userId: user
                )
        );}, child: Text("Complete Group Application"))
          :
      (requestedUsers.contains(user) == true) ?
      Text("Request Sent")
          :
      TextButton(onPressed: (){data('requested', user);}, child: Text("Request"))



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
      stream: FirebaseFirestore.instance.collection('Groups').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot){

        return  (!snapshot.hasData)? Center(child: CircularProgressIndicator()) : (snapshot.data.docs.isEmpty) ? Center(child: Text('No Groups yet... Create one!'))
            : ListView(
          children: eventsListWidget(snapshot),
        );
      },
    );
  }
}