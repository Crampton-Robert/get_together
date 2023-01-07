import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_together/main.dart';


class SignUpPad extends StatefulWidget{
  @override
  _SignUpPadState createState() => _SignUpPadState();
}

class _SignUpPadState extends State<SignUpPad> {

  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible = true;

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
                  Text("Get Started"),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already Have an Account? "),
                          TextButton(onPressed: (){

                            Navigator.pop(context);

                          }, child: Text("Sign In")),
                        ],),
                    ),),




                ]),
          ),

          Form(
            key: _formKey,
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(top:25.0, left: 15, right: 15, bottom: 0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              labelText: 'Full Name',
                            ),
                          ),

                          /*   validator: (value) {
                                  if (value == null || value.isEmpty || EmailValidator.validate(emailcontroller.text) == false) {
                                    return 'Please Enter a Valid Email Address';
                                  }
                                  return null;
                                }, labelText: "Email", */
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0, left: 15, right: 15, bottom: 0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),

                          /*   validator: (value) {
                                  if (value == null || value.isEmpty || EmailValidator.validate(emailcontroller.text) == false) {
                                    return 'Please Enter a Valid Email Address';
                                  }
                                  return null;
                                }, labelText: "Email", */
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            obscureText: _passwordVisible,
                            controller: emailController,
                            decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Password",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                          ),

                          /*validator: (value){
                                  Pattern oyo =
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$';
                                  RegExp regex = new RegExp(oyo.toString());
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (!regex.hasMatch(value))
                                      return 'Password must have:\nOne Upper Case. \nOne Lower Case \nOne Special Character \nMust be at Least 12 Characters long';
                                    else{
                                      return null;}
                                  }
                                },*/

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0, left: 15, right: 15, bottom: 0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.cake),
                              border: OutlineInputBorder(),
                              labelText: 'Date of Birth',
                            ),
                          ),

                          /*   validator: (value) {
                                  if (value == null || value.isEmpty || EmailValidator.validate(emailcontroller.text) == false) {
                                    return 'Please Enter a Valid Email Address';
                                  }
                                  return null;
                                }, labelText: "Email", */
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:0.0, left: 15, right: 15, bottom: 15),
                    child: ElevatedButton(child: Text("Signup"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: password.text
                              );
                            }
                            on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('The account already exists for that email. Please Sign in.'),
                                  ),
                                );
                                return null;
                              }
                            } catch (e) {
                              print(e);
                            }
                            User? user = FirebaseAuth.instance.currentUser;
                            Map <String, dynamic> data = {
                              "uid": user!.uid.toString(),
                            };
                            FirebaseFirestore.instance.collection("users").doc(user.uid).collection("profile").doc("user").set(data);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GetTogether()),
                            );
                          }
                        }
                    ),
                  ),
                ]
            ),
          ),
        ],),



      ],
      ),
    );


  }
}