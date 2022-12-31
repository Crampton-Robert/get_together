import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/Discover/make_or_edit_card.dart';
import 'package:flutter/cupertino.dart';

class MakeOrEditGroups extends StatefulWidget {

  @override
  State<MakeOrEditGroups> createState() => _MakeOrEditGroupsState();
}

class _MakeOrEditGroupsState extends State<MakeOrEditGroups> {

  String size = "small";
  bool isPrivate = true;
  bool wantApplication = true;
  num questions = 1;

  @override

  Widget build(BuildContext context) {

    final title = TextEditingController();
    final description = TextEditingController();
    final questionOne = TextEditingController();
    final questionTwo = TextEditingController();
    final questionThree = TextEditingController();
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
        title: const Text('Create Your Group'),
      ),
      body: ListView(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    size = "small";
                  });
                }, child: Text("Small"),
                style: TextButton.styleFrom(backgroundColor: (size == "small") ? Colors.blue : null),),
                Text("1-15 Members"),
              ],),

              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    size = "medium";
                  });
                }, child: Text("Medium"),
                  style: TextButton.styleFrom(backgroundColor: (size == 'medium') ? Colors.blue : null),),
                Text("15-50 Members"),
              ],),
              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    size = "large";
                  });
                }, child: Text("Large"),
                  style: TextButton.styleFrom(backgroundColor: (size == 'large') ? Colors.blue : null),),
                Text("50-150 Members"),
              ],),
          ]),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    isPrivate = true;
                  });
                }, child: Text("Private"),
                  style: TextButton.styleFrom(backgroundColor:
                  (isPrivate) ? Colors.blue : null
                  ),),
                Text("Must Request Or Be Invited To Join")
              ],),

              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    isPrivate = false;
                  });
                }, child: Text("Public"),
                  style: TextButton.styleFrom(backgroundColor:
                  (isPrivate) ? null : Colors.blue
                  ),),
                Text("Anyone Can Join"),
              ],),



          ],),


Container(child: isPrivate ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    wantApplication = true;
                  });
                }, child: Text("Application"),
                  style: TextButton.styleFrom(backgroundColor:
                  (wantApplication) ? Colors.blue : null
                  ),),
                Text("Requesters Submit an Application")
              ],),

              Column(children: [
                TextButton(onPressed: (){
                  setState(() {
                    wantApplication = false;
                  });
                }, child: Text("No Application"),
                  style: TextButton.styleFrom(backgroundColor:
                  (wantApplication) ? null : Colors.blue
                  ),),
                Text("Group Leader Decision"),
              ],),
            ],) : null

),
          Container(child: wantApplication ?
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: EdgeInsets.all(16.0),
                child:
                TextField(
                  controller: questionOne,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Question 1',
                  ),
                ),
              ),

             Container( child: (questions < 2) ? null : Padding(
                padding: EdgeInsets.all(16.0),
                child:
                TextField(
                  controller: questionTwo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Question 2',
                  ),
                ),
              ),
    ),

             Container( child:(questions != 3) ? null :  Padding(
                padding: EdgeInsets.all(16.0),
                child:
                TextField(
                  controller: questionThree,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Question 3',
                  ),
                ),
              ),),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  TextButton(onPressed: (){
  setState(() {
    if(questions == 3){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Maximum Number of Questions Met.'),
      ));
    }else{
      questions++;
    }
  });
}, child: Text("+ Add a Question")),

  TextButton(onPressed: (){
    setState(() {
      if(questions == 1){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Minimum Number of Questions Met.'),
        ));
      }else{
        questions--;
      }
    });
  }, child: Text("- Remove a Question")),

],),

            ],) : null

          ),


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
                  if (title.text.isNotEmpty && description.text.isNotEmpty && ((wantApplication == true && questionOne.text.isNotEmpty) || wantApplication == false)){
                    //  final user = FirebaseAuth.instance.currentUser!.uid;
                    String user = "123";
                    Navigator.pop(context);
                    Map <String, dynamic> data = {
                      'leader': user,
                      'questionOne': questionOne.text,
                      'questionTwo': questionTwo.text,
                      'questionThree': questionThree.text,
                      'createdBy': user,
                      'privacy': isPrivate,
                      'application': wantApplication,
                      'size': size,
                      "title":title.text,
                      "description": description.text,
                      "createdAt": timestamp,
                      "joinedUsers": [null],
                      "requestedUsers": [null],
                    };
                    FirebaseFirestore.instance.collection('Groups').doc().set(data);
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