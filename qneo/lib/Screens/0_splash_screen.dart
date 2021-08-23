import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:qneo/Screens/homepage.dart';
import 'package:qneo/loggedin.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoggedIn())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4CA9DF), Color(0xFF292E91)],
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Image.asset('assets/images/logo.png',
                      height: 300.0, width: 300.0),
                  CircularProgressIndicator(),
                ]),
              ])),
    );
  }
}
