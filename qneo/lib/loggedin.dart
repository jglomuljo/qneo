import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qneo/Screens/homepage.dart';
import 'package:qneo/Screens/profilepage.dart';

// class LoggedIn extends StatefulWidget {
//   const LoggedIn({Key? key}) : super(key: key);

//   @override
//   _LoggedInState createState() => _LoggedInState();
// }

// class _LoggedInState extends State<LoggedIn> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                   child: CircularProgressIndicator(
//                       backgroundColor: Colors.greenAccent,
//                       valueColor:
//                           new AlwaysStoppedAnimation<Color>(Colors.red)));
//             } else if (snapshot.hasData) {
//               return ProfilePage();
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Something Went Wrong!'));
//             } else {
//               return Home();
//             }
//           },
//         ),
//       );
// }

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
