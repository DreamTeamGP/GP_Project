import 'package:flutter/material.dart';
import 'package:gp_project/Auth/login.dart';
import 'package:gp_project/Auth/signUp1.dart';

import 'package:gp_project/Pages/test.dart';

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
      //home: test(),
      debugShowCheckedModeBanner: false,
    );
  }
}
