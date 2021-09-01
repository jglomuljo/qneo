import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qneo/Screens/profilepage.dart';
import 'package:qneo/models/location.dart';
import 'package:qneo/services/database.dart';
import 'package:qneo/Screens/recent%20location/locationList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qneo/loggedin.dart';

class RecentLocations extends StatelessWidget {
  const RecentLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamProvider<List<Location>?>.value(
        value: DatabaseService().locations,
        initialData: null,
        child: Scaffold(
            backgroundColor: Colors.blue[400],
            appBar: AppBar(
              title: Text('Recent Locations',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Stack(
              children: [
                LocationList(),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue[600],
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 50)),
                    icon: FaIcon(FontAwesomeIcons.locationArrow),
                    label: Text('Return to Profile'),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoggedIn()));
                    },
                  ),
                )
              ],
            )));
  }
}
