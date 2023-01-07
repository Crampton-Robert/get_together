import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_together/User Authentication/Welcome/welcome_screen_parts/sign_up_pad.dart';
import 'package:get_together/User Authentication/password_reset.dart';
import 'package:get_together/main.dart';

class SignInPad extends StatefulWidget{
  @override
  _SignInPadState createState() => _SignInPadState();
}

class _SignInPadState extends State<SignInPad> {

  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible = true;
  dynamic decoration(String label, Widget prefixIcon){

}


  @override
  Widget build(BuildContext context) {


return Scaffold(
  body: Stack(children: [

    Column(children: [
      Container(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.width * 0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(25), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ Image.asset(
                'assets/logo.png',
                height: 50,
                width: 50,
              ),Text("GetTogether"),],),),
              Text("Sign In to Continue")]),
      ),

      Form(
        key: _formKey,
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.only(top:25.0, left: 15, right: 15, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  border:  new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
    borderSide: new BorderSide(),
    ),
                  labelText: 'Email',
                ),
              ),
            ),

            /* validator: (value) {
                            if (value == null || value.isEmpty || EmailValidator.validate(emailcontroller.text) == false) {
                              return 'Please Enter a Valid Email Address';
                            }
                            return null;
                          },
                           labelText: "Email",*/


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: _passwordVisible,
                controller: password,
                decoration:  InputDecoration(
                  suffixIcon:
                  IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility_off: Icons.visibility ,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible ^= true;

                          //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                        });
                      }),
                  labelText: "Password",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),




            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ElevatedButton(child: Text("Sign In"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: password.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No user found for that email'),
                            ),
                          );
                          return null;
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.'),
                            ),
                          );
                          return null;
                        }
                      }

                      final user = FirebaseAuth.instance.currentUser!;
                      DocumentReference datab = FirebaseFirestore.instance
                          .collection('users').doc("${user.uid}").collection("profile").doc("user");

                      await datab.get().then((doc) async {
                        if (doc['city'] == null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => GetTogether()),);
                        }
                        else {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (context) => GetTogether()), (Route<
                              dynamic> route) => false);
                        }
                      });
                    }
                  }
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(onPressed: () {

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          PasswordReset()),
                );

              },
                child: Text("Forgot Password"),),
            ),

          ],

        ) ,
      ),
    ],),


    Align(
      alignment: Alignment.bottomCenter,
      child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't Have an Account? "),
          TextButton(onPressed: (){

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SignUpPad()),);

          }, child: Text("Register")),
        ],),
    ),),
  ],
  ),
);



  }
}