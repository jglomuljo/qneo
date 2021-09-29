import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:qneo/Screens/1_loginpage.dart';
import 'package:qneo/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'headerwithpic.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size screenSize = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            HeaderWithPic(size: size, screenSize: screenSize, user: user),
            Container(
              height: screenSize.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                    child: Text(
                      "Greetings,",
                      style: TextStyle(
                          color: Color(0xFFFF99AA),
                          fontFamily: 'Comfortaa',
                          fontSize: 21,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Text(
                      user.displayName!,
                      style: TextStyle(
                          color: Color(0xFF1E0FAC),
                          fontFamily: 'Comfortaa',
                          fontSize: 21,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Text(
                      user.email!,
                      style: TextStyle(
                        color: Color(0xFF1E0FAC),
                        fontFamily: 'Comfortaa',
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                      "Not you?",
                      style: TextStyle(
                        color: Color(0xFFFF99AA),
                        fontFamily: 'Comfortaa',
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    child: OutlinedButton(
                      //style: ElevatedButton.styleFrom(primary: Colors.red),

                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: Color(0xFF1E0FAC),
                          width: 3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF1E0FAC),
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        await provider.logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFA7DCCA),
  );
}


          // Center(
          //         child: Column(
          //           children: [
          //             SizedBox(height: 200),
          //             Text(
          //               user.displayName!,
          //               style: TextStyle(
          //                   color: Color(0xFF1E0FAC),
          //                   fontFamily: 'Comfortaa',
          //                   fontSize: 21,
          //                   letterSpacing: 0.5,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             //Text(user.displayName!),
          //             SizedBox(height: 20),
          //             Text(
          //               user.email!,
          //               style: TextStyle(
          //                 color: Color(0xFF1E0FAC),
          //                 fontFamily: 'Comfortaa',
          //                 fontSize: 16,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //             //Text(user.email!),
          //             SizedBox(height: 30),
          //             ElevatedButton(
          //               child: Text(
          //                 'Logout',
          //                 style: TextStyle(color: Color(0xFF1E0FAC)),
          //               ),
          //               onPressed: () async {
          //                 final provider = Provider.of<GoogleSignInProvider>(
          //                     context,
          //                     listen: false);
          //                 await provider.logout();
          //                 Navigator.pushReplacement(context,
          //                     MaterialPageRoute(builder: (context) => Home()));
          //               },
          //             ),
          //           ],
          //         ),
          //       )