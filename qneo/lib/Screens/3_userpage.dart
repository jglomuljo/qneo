import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:qneo/Screens/1_loginpage.dart';
import 'package:qneo/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size screenSize = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            //wrap widget - headerwithpic
            height: size.height * 0.3,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.3 - 70,
                  decoration: BoxDecoration(
                    color: Color(0xFFA7DCCA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/profiledeco.png'),
                        width: screenSize.width * 1,
                        height: screenSize.height * 3,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

// Center(
//                   //mainAxisAlignment: MainAxisAlignment.center,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 80),
//                       Text(
//                         user.displayName!,
//                         style: TextStyle(
//                             color: Color(0xFF1E0FAC),
//                             fontFamily: 'Comfortaa',
//                             fontSize: 21,
//                             letterSpacing: 0.5,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       //Text(user.displayName!),
//                       SizedBox(height: 20),
//                       Text(
//                         user.email!,
//                         style: TextStyle(
//                           color: Color(0xFF1E0FAC),
//                           fontFamily: 'Comfortaa',
//                           fontSize: 16,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       //Text(user.email!),
//                       SizedBox(height: 30),
//                       ElevatedButton(
//                         child: Text(
//                           'Logout',
//                           style: TextStyle(color: Color(0xFF1E0FAC)),
//                         ),
//                         onPressed: () {
//                           final provider = Provider.of<GoogleSignInProvider>(
//                               context,
//                               listen: false);
//                           provider.logout();
//                         },
//                       ),
//                     ],
//                   ),
//                 )

    //       alignment: Alignment.center,
    //       color: Colors.white,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           CircleAvatar(
    //             radius: 70,
    //             backgroundImage: NetworkImage(user.photoURL!),
    //           ),
    //           SizedBox(height: 40),
    //           Text(
    //             user.displayName!,
    //             style: TextStyle(
    //                 color: Color(0xFF1E0FAC),
    //                 fontFamily: 'Comfortaa',
    //                 fontSize: 21,
    //                 letterSpacing: 0.5,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //           //Text(user.displayName!),
    //           SizedBox(height: 20),
    //           Text(
    //             user.email!,
    //             style: TextStyle(
    //               color: Color(0xFF1E0FAC),
    //               fontFamily: 'Comfortaa',
    //               fontSize: 16,
    //               letterSpacing: 0.5,
    //             ),
    //           ),
    //           //Text(user.email!),
    //           SizedBox(height: 30),
    //           ElevatedButton(
    //             child: Text(
    //               'Logout',
    //               style: TextStyle(color: Color(0xFF1E0FAC)),
    //             ),
    //             onPressed: () {
    //               final provider =
    //                   Provider.of<GoogleSignInProvider>(context, listen: false);
    //               provider.logout();
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFA7DCCA),
  );
}
