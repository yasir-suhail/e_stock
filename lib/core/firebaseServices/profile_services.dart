import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:e_stock/model/owner_model.dart';
import 'package:e_stock/model/salesman_model.dart';

class ProfileServices {
  // Firebase Authentication
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Owner database reference
  final DatabaseReference ownerUsers =
  FirebaseDatabase.instance.ref('owner');

  // Salesman database reference
  final DatabaseReference salesmanUsers =
  FirebaseDatabase.instance.ref('salesman');

  // GET CURRENT OWNER DATA

  Future<OwnerModel?> getOwnerData() async {
    // Get the currently logged-in Firebase user
    final User? user = auth.currentUser;

    // If nobody is logged in, return null
    if (user == null) {
      return null;
    }

    // Get owner data using the current user's UID
    final DataSnapshot snapshot =
    await ownerUsers.child(user.uid).get();

    // If owner data does not exist
    if (!snapshot.exists) {
      return null;
    }

    // Convert Firebase data into a Dart Map
    final Map<String, dynamic> data =
    Map<String, dynamic>.from(snapshot.value as Map);

    // Convert Map into OwnerModel
    return OwnerModel.fromMap(data);
  }

  // GET CURRENT SALESMAN DATA

  Future<SalesmanModel?> getSalesmanData() async {
    // Get the currently logged-in Firebase user
    final User? user = auth.currentUser;

    // If nobody is logged in, return null
    if (user == null) {
      return null;
    }

    // Get salesman data using the current user's UID
    final DataSnapshot salesmanSnapshot =
    await salesmanUsers.child(user.uid).get();

    // If salesman data does not exist
    if (!salesmanSnapshot.exists) {
      return null;
    }

    // Convert Firebase salesman data into a Map
    final Map<String, dynamic> salesmanData =
    Map<String, dynamic>.from(
      salesmanSnapshot.value as Map,
    );

    // Convert the Map into SalesmanModel
    final SalesmanModel salesman =
    SalesmanModel.fromMap(salesmanData);

    // Get the owner ID stored inside salesman data
    final String? ownerId = salesman.ownerId;

    // This will contain the factory name
    String? factoryName;

    // If salesman has an owner ID
    if (ownerId != null) {

      // Get the owner data using ownerId
      final DataSnapshot ownerSnapshot =
      await ownerUsers.child(ownerId).get();

      // Check if owner data exists
      if (ownerSnapshot.exists) {

        // Convert owner Firebase data into Map
        final Map<String, dynamic> ownerData =
        Map<String, dynamic>.from(
          ownerSnapshot.value as Map,
        );

        // Get factory name from owner data
        factoryName = ownerData['factoryName'];
      }
    }

    // Return a new SalesmanModel
    //
    // The salesman information comes from salesman database.
    // The factory name comes from owner database.
    return SalesmanModel(
      uid: salesman.uid,
      name: salesman.name,
      email: salesman.email,
      phone: salesman.phone,
      ownerId: salesman.ownerId,
      factoryName: factoryName,
    );
  }
}