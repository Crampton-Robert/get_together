import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_together/User Authentication/Welcome/welcome_screen_parts/sign_in_pad.dart';
class Welcome extends StatefulWidget{
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {

      return SignInPad();
  }
}
