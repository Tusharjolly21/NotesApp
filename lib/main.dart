import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/pages/homepage.dart';
import 'package:notes_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.deepPurple,
            accentColor: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.black),
        home: FirebaseAuth.instance.currentUser == null
            ? LoginPage()
            : HomePage());
  }
}
