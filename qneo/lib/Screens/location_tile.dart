import 'package:flutter/material.dart';
import 'package:qneo/models/location.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationTile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final Location loc;
  LocationTile(this.loc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
          title: Text(loc.location),
          subtitle: Text(loc.user),
        ),
      ),
    );
  }
}
