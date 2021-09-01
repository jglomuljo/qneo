import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qneo/Screens/recent%20location/recentLocations.dart';
import 'package:qneo/provider/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        alignment: Alignment.center,
        color: Colors.blue[800],
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
                  color: Colors.white,
                  fontFamily: 'Comfortaa',
                  fontSize: 21,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text(
              'E-mail: ' + user.email!,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[600],
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50)),
              icon: FaIcon(FontAwesomeIcons.locationArrow),
              label: Text('Recent Locations'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RecentLocations()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
