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
    String date =
        DateFormat("yyyy-MM-dd hh:mma").format(userLocations['dateTime']);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage:
                AssetImage('assets/images/${userLocations['status']}.png'),
          ),
          title: Text(locations.building),
          subtitle: Text(date.toString()),
          trailing: Text(locations.room),
        ),
      ),
    );
  }
}
