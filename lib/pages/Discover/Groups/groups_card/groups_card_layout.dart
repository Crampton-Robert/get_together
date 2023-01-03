import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_class_groups_and_events.dart';

class GroupsCardLayout extends StatefulWidget {

  final String title;
  final String privacy;
  final String size;
  final String description;
  final String documentId;
  final String leader;
  final String userId;
  final String questionOne;
  final String questionTwo;
  final String questionThree;

  GroupsCardLayout({Key? key, required this.title, required this.privacy, required this.size, required this.description, required this.documentId, required this.leader, required this.userId, required this.questionOne, required this.questionTwo, required this.questionThree,}) : super(key: key);

  @override
  State<GroupsCardLayout> createState() => _GroupsCardLayoutState();
}

class _GroupsCardLayoutState extends State<GroupsCardLayout> {
  @override
  Widget build(BuildContext context) {

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
                Text(widget.title),
                (widget.privacy) ? Row(children: [Text("Private Group (${widget.size})"), Icon(Icons.lock), ],) : Row(children: [ Text("Public Group (${widget.size})"), Icon(Icons.lock),],),
              ],),
          ),

          JoinButton(
              documentId: documentId,
              questionOne: questionOne,
              questionTwo: questionTwo,
              questionThree: questionThree,
              leader: leader,
              userId: userId,

          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(widget.description,),
          ),






          Padding(padding: EdgeInsets.all(25), child: Text(true_list_length.toString()+" $peopleHave_Or_personHas Joined This Event"),),



        ],
      ),
    );

  }
}


