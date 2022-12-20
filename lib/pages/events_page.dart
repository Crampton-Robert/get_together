import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/make_or_edit_card.dart';
import 'package:get_together/pages/Profile Page/profile_page.dart';

class EventsCardList extends StatefulWidget {
  @override
  _EventsCardListState createState() => _EventsCardListState();
}

class _EventsCardListState extends State<EventsCardList> {

  List<Widget> eventsListWidget(AsyncSnapshot snapshot){
    return snapshot.data.docs.map<Widget>((docs){

      return Card(
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
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
     stream: FirebaseFirestore.instance.collection('Events').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot){




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
          body:  (!snapshot.hasData)? Center(child: CircularProgressIndicator()) : (snapshot.data.docs.isEmpty) ? Center(child: Text('Be The First to Post an Event in your Area!'))
          : ListView(
            children: eventsListWidget(snapshot),
        ),
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

      },
    );
  }
}