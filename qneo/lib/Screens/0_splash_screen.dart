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
          color: Color(0xFFFFFFFF),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Image.asset('assets/images/logo.png',
                      height: 300.0, width: 300.0),
                  SizedBox(height: 15),
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFF1E0FAC),
                    valueColor: AlwaysStoppedAnimation(Color(0xFFA7DCCA)),
                    strokeWidth: 10,
                  ),
                ]),
              ])),
    );
  }
}
