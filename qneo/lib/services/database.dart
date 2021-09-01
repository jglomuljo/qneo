import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qneo/models/location.dart';

class DatabaseService {
  //final String uid;
  DatabaseService();

  //collection
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

  //location list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Location(
          user: doc.get('User') ?? '', location: doc.get('location') ?? '');
    }).toList();
  }

  //get location stream
  Stream<List<Location>> get locations {
    return FirebaseFirestore.instance
        .collection('locations')
        .snapshots()
        .map(_locationListFromSnapshot);
  }
}
