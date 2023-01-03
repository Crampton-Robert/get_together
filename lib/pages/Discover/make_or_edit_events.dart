import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MakeOrEditEvents extends StatefulWidget {

  @override
  State<MakeOrEditEvents> createState() => _MakeOrEditEventsState();
}

class _MakeOrEditEventsState extends State<MakeOrEditEvents> {


  @override

  Widget build(BuildContext context) {

    final title = TextEditingController();
    final description = TextEditingController();
    final timestamp = DateTime.now().microsecondsSinceEpoch;

    final snackBar = SnackBar(
      content: const Text('Your Event Has Been Drafted.'),
      action: SnackBarAction(
        label: 'Delete Draft',
        onPressed: () {},
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop();
            (title.text.isNotEmpty && title.text.isNotEmpty) ? ScaffoldMessenger.of(context).showSnackBar(snackBar) :null;
          },

        ),
        title: const Text('Create Event'),
      ),
      body: ListView(
        children: [
       Padding(
         padding: EdgeInsets.all(16.0),
         child:
         TextField(
            controller: title,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
          ),
    ),
    Padding(
    padding: EdgeInsets.all(16.0),
    child:
         TextField(
            controller: description,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),
    ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                 if (title.text.isNotEmpty && description.text.isNotEmpty){
              //  final user = FirebaseAuth.instance.currentUser!.uid;
                  String user = "123";
                  Navigator.pop(context);
                  Map <String, dynamic> data = {
                    'createdBy': user,
                    "title":title.text,
                    "description": description.text,
                    "createdAt": timestamp,
                    "joinedUsers": [null],
                  };
                  FirebaseFirestore.instance.collection('Events').doc(user+'+'+timestamp.toString()).set(data);
                }else{
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   Null;}

                  },
                child: const Text('Save'),),
          TextButton(
          onPressed: () {
    Navigator.pop(context);
    },
    child: const Text('Cancel'),)
            ],
          )
        ],
      ),
    );
  }
}