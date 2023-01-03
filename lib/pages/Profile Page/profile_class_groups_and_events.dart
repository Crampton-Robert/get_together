import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';

class GroupsAndEvents extends StatefulWidget {

  final String groupsOrEvents;

  GroupsAndEvents({Key? key, required this.groupsOrEvents}) : super(key: key);


  @override
  State<GroupsAndEvents> createState() => _GroupsAndEventsState();
}
var user = '124';
class _GroupsAndEventsState extends State<GroupsAndEvents> {



  List<Widget> GroupsAndEventsListWidget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((docs) {

      String documentId = docs.id.toString();
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center ,
            children:[


              Text(docs['title'],),

              TextButton(onPressed: () {
                FirebaseFirestore.instance.collection('Events')
                    .doc(documentId)
                    .update({"joinedUsers": FieldValue.arrayRemove([user])});
              }, child: Text("Leave Event")),
]
            ),
          ),
        );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('${widget.groupsOrEvents}').where('joinedUsers', arrayContains: user).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*.25,
                  child: (!snapshot.hasData)?
                  Center(child: CircularProgressIndicator())
                      :
                  (snapshot.data.docs.isEmpty) ?
                  Center(child: Text('Joined ${widget.groupsOrEvents} Will be Visible Here'))
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