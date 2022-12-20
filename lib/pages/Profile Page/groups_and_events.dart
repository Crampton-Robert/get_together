import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/make_or_edit_card.dart';

class GroupsAndEvents extends StatefulWidget {
  @override
  State<GroupsAndEvents> createState() => _GroupsAndEventsState();
}

class _GroupsAndEventsState extends State<GroupsAndEvents> {

  List<Widget> GroupsAndEventsListWidget(AsyncSnapshot snapshot){
    return snapshot.data.docs.map<Widget>((docs){

      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height,
        child: Card(
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
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Events').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*.25,
                  child: (!snapshot.hasData)?
                  Center(child: CircularProgressIndicator())
                      :
                  (snapshot.data.docs.isEmpty) ?
                  Center(child: Text('Join an Event'))
                      :
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: GroupsAndEventsListWidget(snapshot),
                  ),








                );

      },
    );
  }
}