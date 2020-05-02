import 'package:flutter/material.dart';
import 'package:loginpage/pages/fillProfile.dart';
import 'package:loginpage/pages/fillTutorProfile.dart';
import 'pages/signup.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/map.dart';

String url = 'https://abcd1f12.ngrok.io';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new Signup(),
        '/classdetails': (BuildContext context) => new Home_Page(),
      },
      home: new LoginForm(),
    );
  }
}

