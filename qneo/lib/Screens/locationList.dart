import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qneo/models/location.dart';
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

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        if (locations[index].user == user.uid) {
          return LocationTile(locations[index]);
        } else {
          return SizedBox(height: 0);
        }
      },
    );
  }
}
