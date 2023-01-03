import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_class_groups_and_events.dart';

class GroupApplication extends StatefulWidget {

  final String documentId;
  final String questionOne;
  final String questionTwo;
  final String questionThree;
  final String leader;
  final String userId;

  GroupApplication({Key? key, required this.userId, required this.documentId, required this.questionOne, required this.questionTwo, required this.questionThree, required this.leader}) : super(key: key);

  @override
  State<GroupApplication> createState() => _GroupApplicationState();
}

class _GroupApplicationState extends State<GroupApplication> {

  final answerOne = TextEditingController();
  final answerTwo = TextEditingController();
  final answerThree = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var user = widget.userId;

    return AlertDialog(
      title: Text("Please Answer The Questions"),
      content: Column(children: [

        Text("Question: ${widget.questionOne}"),

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

        Container(child: (widget.questionTwo == null ||
            widget.questionTwo == '') ? null : Column(children: [
          Text("Question: ${widget.questionTwo}"),
          Padding(
            padding: EdgeInsets.all(16.0),
            child:
            TextField(
              controller: answerTwo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Response',
              ),
            ),
          ),
        ],),),
        Container(child: (widget.questionThree == null ||
            widget.questionThree == '') ? null : Column(
          children: [
            Text("Question: ${widget.questionThree}"),
            Padding(
              padding: EdgeInsets.all(16.0),
              child:
              TextField(
                controller: answerThree,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Response',
                ),
              ),
            ),
          ],),),

      ],),
      actions: [
        CupertinoDialogAction(child: Text("Submit"),
          onPressed: () {
            Map <String, dynamic> data = {
              'answerOne': answerOne.text,
              'answerTwo': answerTwo.text,
              'answerThree': answerThree.text,
            };
            FirebaseFirestore.instance.collection(widget.leader)
                .doc(
                "Groups Led").collection(user)
                .add(data);

            FirebaseFirestore.instance.collection(user).doc(
                "Groups Requested").collection(widget.documentId).add(
                data);

            FirebaseFirestore.instance.collection('Groups').doc(
                widget.documentId).update({"requestedUsers": FieldValue
                .arrayUnion([user])});
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("Cancel"), onPressed: () {
          Navigator.pop(context);
        },),
      ],
    );

  }
}





