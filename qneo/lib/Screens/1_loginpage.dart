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
          color: Colors.blue,
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
            child: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Image(
                    image: AssetImage(
                        'assets/images/Ateneo_de_Davao_University_logo.png'),
                    width: screenSize.width * .45,
                  ),
                  SizedBox(height: 60),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.blue,
                      ),
                      hintText: 'E-mail',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.blue)),
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.blue,
                    ),
                    hintText: 'Password',
                  )),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue[800],
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 50)),
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Sign In with Google'),
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
                ],
              )),
            ),
          ),
        ),
      ]),
    );
  }
}
