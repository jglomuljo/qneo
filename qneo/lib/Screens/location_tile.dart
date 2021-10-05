import 'package:flutter/material.dart';
import 'package:qneo/models/allLocations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class LocationTile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  //final Location loc;
  final AllLocations locations;
  final userLocations;
  LocationTile(this.locations, this.userLocations);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String date =
        DateFormat("yyyy-MM-dd hh:mma").format(userLocations['dateTime']);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        shadowColor: Colors.black,
        color: userLocations['status'] == 'Time-in'
            ? Color(0xFF97E6C8)
            : Color(0xFFFFBDBF),
        margin: EdgeInsets.fromLTRB(
          screenSize.width * .05,
          screenSize.height * .005,
          screenSize.width * .05,
          screenSize.height * .005,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage:
                AssetImage('assets/images/${userLocations['status']}.png'),
          ),
          title: Text(locations.building,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              )),
          subtitle: Text(date.toString(),
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 10,
                letterSpacing: 0.5,
              )),
          trailing: Text(locations.room,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 14,
                letterSpacing: 0.5,
              )),
        ),
      ),
    );
  }
}
