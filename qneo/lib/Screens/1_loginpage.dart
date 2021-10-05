import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:qneo/provider/google_sign_in.dart';
import '2_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                  padding:
                      EdgeInsets.fromLTRB(0, screenSize.height * 0.05, 0, 30),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/loginart.png'),
                        width: screenSize.width * .9,
                        //fit: BoxFit.fill,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Q-NEO — a Personal Location Tracking app designed for Ateneo de Davao University Jacinto Campus",
                        style: TextStyle(
                          color: Color(0xFFFF99AA),
                          fontFamily: 'Comfortaa',
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF1E0FAC),
                            onPrimary: Colors.white,
                            minimumSize:
                                Size(double.infinity, screenSize.width * .13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        icon: FaIcon(FontAwesomeIcons.google),
                        label: Text(
                          'Sign In with Google',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        onPressed: () async {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          await provider.googleLogin();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "*Please use your school Google account.*",
                        style: TextStyle(
                          color: Color(0xFFFF99AA),
                          fontFamily: 'Comfortaa',
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Image(
                        image: AssetImage(
                            'assets/images/Ateneo_de_Davao_University_logo.png'),
                        width: screenSize.width * .20,
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
