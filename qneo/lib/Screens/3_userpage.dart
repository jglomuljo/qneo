import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qneo/Screens/1_loginpage.dart';
import 'package:qneo/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 60),
            Text(
              'Name: ' + user.displayName!,
              style: TextStyle(
                  color: Color(0xFF1E0FAC),
                  fontFamily: 'Comfortaa',
                  fontSize: 21,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            //Text(user.displayName!),
            SizedBox(height: 40),
            Text(
              'E-mail: ' + user.email!,
              style: TextStyle(
                  color: Color(0xFF1E0FAC),
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            //Text(user.email!),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Color(0xFF1E0FAC)),
              ),
              onPressed: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                await provider.logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
