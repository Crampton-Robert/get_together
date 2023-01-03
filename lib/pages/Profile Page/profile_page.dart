import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_class_groups_and_events.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
bool isSelected = true;
String groupOrEvent = "Events";



  @override
  Widget build(BuildContext context) {

    if (isSelected == true){
      groupOrEvent = "Events";
    } else {
      groupOrEvent = 'Groups';
    }

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: const Text('Profile'),
        ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children : [CircleAvatar(),
            Text("Name"),
              Container(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                    TextButton(onPressed: (){
                      setState(() {
                        isSelected = true;
                      });
                    }, child: Text("Events"),
                      style: TextButton.styleFrom(backgroundColor:
                      (isSelected) ? Colors.blue : null
                      ),),

                    TextButton(onPressed: (){
                      setState(() {
                        isSelected = false;
                      });
                    }, child: Text("Groups"),
                      style: TextButton.styleFrom(backgroundColor:
                      (isSelected) ? null : Colors.blue
                      ),),


                ],),

              ),



            Text("$groupOrEvent Joined"),
              GroupsAndEvents(groupsOrEvents: groupOrEvent,),
            Text("$groupOrEvent Leading"),
]
          ),
      );

  }
}