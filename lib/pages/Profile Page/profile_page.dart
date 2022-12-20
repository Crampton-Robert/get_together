import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/make_or_edit_card.dart';
import 'package:get_together/pages/Profile Page/groups_and_events.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
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
              GroupsAndEvents(),
            Text("Events Created"),
              GroupsAndEvents(),
            Text("Events Drafted"),
              GroupsAndEvents(),
]
          ),
      );

  }
}