import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/make_or_edit_card.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<Widget> eventsListWidget(AsyncSnapshot snapshot){
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
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: const Text('Profile'),
        ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children : [CircleAvatar(),
            Text("Name"),
            ButtonBar(
              children: [
                TextButton(onPressed: () {}, child: Text("Events")),
                TextButton(onPressed: () {}, child: Text("groups")),
              ],
            ),
            Text("Events Joined"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: eventsListWidget(snapshot),
              ),
            ),
            Text("Events Created"),
            Text("Events Drafted"),
]
          ),
      );

    },
    );
  }
}