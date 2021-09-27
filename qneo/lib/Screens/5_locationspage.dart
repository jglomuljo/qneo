import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qneo/models/allLocations.dart';
import 'package:qneo/models/location.dart';
import 'package:qneo/services/database.dart';
import 'package:qneo/Screens/locationList.dart';

class LocationsPage extends StatefulWidget {
  @override
  _LocationsPage createState() => _LocationsPage();
}

class _LocationsPage extends State<LocationsPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<AllLocations>?>.value(
            value: DatabaseService().allLocations,
            initialData: null,
          ),
          StreamProvider<List<Location>?>.value(
            value: DatabaseService().locations,
            initialData: null,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title:
                Text('Recent Locations', style: TextStyle(color: Colors.white)),
          ),
          body: LocationList(),
        ));
  }
}
