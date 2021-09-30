import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qneo/models/location.dart';
import 'package:qneo/models/allLocations.dart';
import 'package:qneo/Screens/location_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final locations = Provider.of<List<Location>?>(context) ?? [];
    final allLocations = Provider.of<List<AllLocations>?>(context) ?? [];
    List userLocs = [];
    for (final record in locations) {
      if (record.user == user.uid) {
        var temp = {
          'User': record.user,
          'dateTime': record.dateTime,
          'location': record.location,
          'status': record.status
        };
        userLocs.add(temp);
      }
    }

    userLocs.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));

    return ListView.builder(
      itemCount: userLocs.length,
      itemBuilder: (context, index) {
        for (var i = 0; i < allLocations.length; i++) {
          if (allLocations[i].uid == userLocs[index]["location"]) {
            return LocationTile(allLocations[i], userLocs[index]);
          }
        }

        return SizedBox(height: 0);
      },
    );
  }
}
