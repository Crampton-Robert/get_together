import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_class_groups_and_events.dart';

class JoinButton extends StatefulWidget {
  final String documentId;
  final String leader;
  final String userId;
  final String questionOne;
  final String questionTwo;
  final String questionThree;

  GroupApplication({Key? key, required this.documentId, required this.leader, required this.userId, required this.questionOne, required this.questionTwo, required this.questionThree,}) : super(key: key);
  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {

  data(String addOrRemove, user){

    FieldValue? myArray;

    var documentReference = FirebaseFirestore.instance.collection('Groups').doc(widget.documentId);
    var arrayName = "joinedUsers";


    if (addOrRemove == "remove") {
      myArray = FieldValue.arrayRemove([user]);
      documentReference.update({"$arrayName": myArray});
    } else if (addOrRemove == "add") {
      myArray = FieldValue.arrayUnion([user]);
      documentReference.update({"$arrayName": myArray});
    } else if (addOrRemove == 'delete') {
      documentReference.delete();
    } else if (addOrRemove == 'requested'){
      documentReference.update({"$arrayName": FieldValue.arrayUnion([user])});
    }
  }

  @override
  Widget build(BuildContext context) {
var user = widget.userId;

    return Padding(
      padding: EdgeInsets.all(5),
      child:Align(
          alignment: AlignmentDirectional.centerEnd,
          child: (joined.contains(user) == true)
              ?
          TextButton(onPressed: () {data("remove", user);}, child: Text("Leave Group"))
              :
          (widget.privacy == false)
              ?
          TextButton(onPressed: (){data('add', user);}, child: Text("Join"))
              :
          (widget.application == true && requestedUsers.contains(user) == false) ?

          TextButton(onPressed: (){
            showCupertinoDialog(
                context: context,
                builder: (context) =>
                    GroupApplication(
                        documentId: documentId,
                        questionOne: docs['questionOne'].toString(),
                        questionTwo: docs['questionTwo'].toString(),
                        questionThree: docs['questionThree'].toString(),
                        leader: docs['leader'].toString(),
                        userId: user
                    )
            );}, child: Text("Complete Group Application"))
              :
          (requestedUsers.contains(user) == true) ?
          Text("Request Sent")
              :
          TextButton(onPressed: (){data('requested', user);}, child: Text("Request"))



      ),
    ),

  }
}





