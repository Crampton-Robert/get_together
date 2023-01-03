import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Discover/make_or_edit_groups.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';
import 'package:get_together/pages/Discover/class_events_cards.dart';
import 'package:get_together/pages/Discover/class_groups_cards.dart';

class EventsCardList extends StatefulWidget {
  @override
  _EventsCardListState createState() => _EventsCardListState();
}

class _EventsCardListState extends State<EventsCardList> {
  bool isEvents = true;
  bool isEventsSelected = true;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()
                    ),
                  );
                },
              )
            ],
            title: const Text('Discover'),
          ),
          body: Column(
            children:[
              Container(
                height: MediaQuery.of(context).size.height*.05,
                child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Expanded(child: TextButton(onPressed: (){
                  setState(() {
                    isEvents = true;
                    isEventsSelected = true;
                  });
                }, child: Text("Events"),
                style: TextButton.styleFrom(backgroundColor: isEventsSelected ? Colors.lightBlue[800] : null),),
               ),
               Expanded(child: TextButton(onPressed: (){

                    setState(() {
                      isEvents = false;
                      isEventsSelected = false;
                    });
                }, child: Text("Groups"),
                  style: TextButton.styleFrom(backgroundColor: isEventsSelected ?  null : Colors.lightBlue[800]),
                ),
               ),
              ],),),

         Expanded(child: (isEvents) ? EventsCards() : GroupsCards(),),
],
          ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => isEventsSelected ? MakeOrEditEvents() : MakeOrEditGroups(),
                ),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.navigation),
          ),
        );
  }
}