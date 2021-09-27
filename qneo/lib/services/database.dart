import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qneo/models/location.dart';
import 'package:qneo/models/allLocations.dart';

class DatabaseService {
  //final String uid;
  DatabaseService();

  //collection
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

//collection of AllLocations
  final CollectionReference allLocationCollection =
      FirebaseFirestore.instance.collection('AllLocations');

  //location list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Location(
          user: doc.get('User') ?? '',
          dateTime: doc.get('dateTime').toDate() ?? '',
          location: doc.get('location') ?? '',
          status: doc.get('status') ?? '');
    }).toList();
  }

  //location list from snapshot
  List<AllLocations> _allLocationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AllLocations(
          building: doc.get('Building') ?? '',
          floor: doc.get('Floor') ?? '',
          room: doc.get('Room') ?? '',
          uid: doc.get('UID') ?? '');
    }).toList();
  }

  //get location stream
  Stream<List<Location>> get locations {
    return FirebaseFirestore.instance
        .collection("locations")
        .snapshots()
        .map(_locationListFromSnapshot);
  }

  //get all location stream
  Stream<List<AllLocations>> get allLocations {
    return FirebaseFirestore.instance
        .collection('AllLocations')
        .snapshots()
        .map(_allLocationListFromSnapshot);
  }

  //add a record in locations collection
  Future updateUserData(String user, String locationID, String status) async {
    var now = DateTime.now();
    return await locationCollection.doc().set({
      'User': user,
      'location': locationID,
      'dateTime': now,
      'status': status
    });
  }
}
