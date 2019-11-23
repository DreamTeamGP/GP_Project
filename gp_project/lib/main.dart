import 'package:flutter/material.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Auth/signUp1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.cyan,

      ),
      home: login(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

