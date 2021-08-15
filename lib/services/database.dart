import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_coffee_app/models/coffee.dart';
import 'package:get_coffee_app/models/user.dart';

class DatabaseService
{
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection("coffees");

  Future updateUserData(String sugars, String name, int strength) async
  {
    return await coffeeCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  //coffee list from snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc)
    {
      return Coffee(
        name: doc.get("name") ?? " ",
        sugars: doc.get("sugars") ?? "0", 
        strength: doc.get("strength") ?? 0
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.get("name"),
      sugars: snapshot.get("sugars"), 
      strength: snapshot.get("strength")
    );
  }


  //get coffees stream
  Stream<List<Coffee>> get coffees
  {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData
  {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}