import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late Timer _timer;
class WaitingEmailVerification extends StatefulWidget{
 final String emailaddress;
  WaitingEmailVerification({required this.emailaddress});
  @override
  _WaitingEmailVerificationState createState() => _WaitingEmailVerificationState();
}

class _WaitingEmailVerificationState extends State<WaitingEmailVerification> {

  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
       FirebaseAuth.instance.currentUser!..reload();
        var user = FirebaseAuth.instance.currentUser!;
        if (user.emailVerified) {
          setState((){
            user.emailVerified;
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //       builder: (context) => MoreAccountInfo()),
            // );
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("A verification link has been sent to ${widget.emailaddress}", style: TextStyle(fontSize: 20, color: Colors.black),)),
              Row(
                children: [
                  Text("No Email? "),

              TextButton(onPressed: (){
                User? user = FirebaseAuth.instance.currentUser;
              if (user!= null && !user.emailVerified) {
                user.sendEmailVerification();
              }}, child: Text("Try again"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}