import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qneo/Screens/homepage.dart';
import 'package:qneo/Screens/profilepage.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ProfilePage();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went Wrong'));
            } else {
              return Home();
            }
          },
        ),
      );
}
