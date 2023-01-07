import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_together/pages/Discover/events_page.dart';
import 'package:get_together/theme.dart';
import 'package:get_together/User Authentication/Welcome/welcome.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetTogether());
}

class GetTogether extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetTogether',
      themeMode: appTheme.themeMode, //👈 this is the themeMode defined in the AppTheme class
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
       return Welcome();
        },
      ),
    );
  }
}