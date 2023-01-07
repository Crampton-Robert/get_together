
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget{
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {  Navigator.pop(context); }, icon: Icon(Icons.arrow_back),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Follow the Link in the Email Sent to Reset Your Password"),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email"
                ),

              ),

              ElevatedButton(onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                Navigator.pop(context);
              }, child: Text("Send Reset Link")),
            ],
          ),
        ),
      ),
    );
  }
}