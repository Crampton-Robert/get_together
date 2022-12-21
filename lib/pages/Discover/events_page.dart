import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'package:get_together/pages/Discover/make_or_edit_card.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';
import 'package:get_together/pages/Discover/class_group_and_events_cards.dart';

class EventsCardList extends StatefulWidget {
  @override
  _EventsCardListState createState() => _EventsCardListState();
}

class _EventsCardListState extends State<EventsCardList> {

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
          body: GroupAndEventsCards(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MakeOrEditCards()
                ),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.navigation),
          ),
        );

  }
}