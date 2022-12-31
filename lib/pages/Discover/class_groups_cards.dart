import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/make_or_edit_card.dart';
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
      final answerOne = TextEditingController();
      final answerTwo = TextEditingController();
      final answerThree = TextEditingController();
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
                child://  final user = FirebaseAuth.instance.currentUser!.uid;
    (joined.contains(user) == true) ?
    TextButton(onPressed: () {
      FirebaseFirestore.instance.collection('Groups')
          .doc(documentId)
          .update({"joinedUsers": FieldValue.arrayRemove([user])});
    }, child: Text("Leave Group")) : (docs["privacy"] == false) ?
      TextButton(onPressed: (){
        FirebaseFirestore.instance.collection('Groups').doc(documentId).update({"joinedUsers": FieldValue.arrayUnion([user])});
      }, child: Text("Join")) : (docs["application"] == true && requestedUsers.contains(user) == false) ?

    TextButton(onPressed: (){
      showCupertinoDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          title: Text("Please Answer The Questions"),
          content: Column(children: [

            Text("Question: ${docs["questionOne"]}"),

            Padding(
              padding: EdgeInsets.all(16.0),
              child:
              TextField(
                controller: answerOne,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Response',
                ),
              ),
            ),

            Container(child: (docs["questionTwo"] == null || docs["questionTwo"]=='' ) ? null : Column( children:[  Text("Question: ${docs["questionTwo"]}"),   Padding(
              padding: EdgeInsets.all(16.0),
              child:
              TextField(
                controller: answerTwo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Response',
                ),
              ),
            ),], ),),
            Container(child: (docs["questionThree"] == null || docs["questionThree"] == '' ) ? null : Column( children:[  Text("Question: ${docs["questionThree"]}"),   Padding(
              padding: EdgeInsets.all(16.0),
              child:
              TextField(
                controller: answerThree,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Response',
                ),
              ),
            ),], ),),

          ],),
          actions: [
            CupertinoDialogAction(child: Text("Submit"),
              onPressed: (){
                Map <String, dynamic> data = {
                  'answerOne': answerOne.text,
                  'answerTwo': answerTwo.text,
                  'answerThree': answerThree.text,
                };
                FirebaseFirestore.instance.collection(docs['leader']).doc("Groups Led").collection(user).add(data);

                FirebaseFirestore.instance.collection(user).doc("Groups Requested").collection(documentId).add(data);

                FirebaseFirestore.instance.collection('Groups').doc(documentId).update({"requestedUsers": FieldValue.arrayUnion([user])});
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("Cancel"), onPressed: (){Navigator.pop(context);},),
          ],
        ),
      );

    }, child: Text("Complete Group Application")) : (requestedUsers.contains(user) == true) ? Text("Request Sent"):  TextButton(onPressed: (){
      FirebaseFirestore.instance.collection('Events').doc(documentId).update({"joinedUsers": FieldValue.arrayUnion([user])});
    }, child: Text("Request"))



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