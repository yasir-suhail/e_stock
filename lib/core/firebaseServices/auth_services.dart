import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../firebase_options.dart';

class AuthServices {
  // Main Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Owner database
  final DatabaseReference ownerUsers = FirebaseDatabase.instance.ref('owner');

  // Salesman database
  final DatabaseReference salesmanUsers = FirebaseDatabase.instance.ref(
    'salesman',
  );

  // -----------------OWNER SIGNUP------------

  Future<void> signupOwner({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String factoryName,
  }) async {
    final UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = credential.user;

    if (user == null) {
      throw Exception('User account was not created');
    }
    // owner uid
    final String uid = user.uid;
    // save the owner information
    await ownerUsers.child(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'owner',
      'factoryName': factoryName,
    });
  }

  // ---------------------OWNER LOGIN-----------------

  Future<void> loginOwner({
    required String email,
    required String password,
  }) async {
    // Login with Firebase Authentication
    await auth.signInWithEmailAndPassword(email: email, password: password);

    final User? user = auth.currentUser;

    if (user == null) {
      throw Exception('Login failed');
    }

    // Check whether this UID exists under owner
    final DataSnapshot snapshot = await ownerUsers.child(user.uid).get();

    if (!snapshot.exists) {
      await auth.signOut();

      throw Exception(
        'This account belongs to a salesman. Please use the Salesman login.',
      );
    }
  }


  // ------------------CREATE SALESMAN----------------

  Future<void> createSalesman({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    // The Owner must already be logged in
    final User? owner = auth.currentUser;

    if (owner == null) {
      throw Exception('Owner is not logged in');
    }

    // Create secondary Firebase app
    final FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'secondaryApp',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Auth belonging to the secondary app
    final FirebaseAuth secondaryAuth = FirebaseAuth.instanceFor(
      app: secondaryApp,
    );

    try {
      // Create Salesman Firebase Authentication account
      final UserCredential credential = await secondaryAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? salesman = credential.user;

      if (salesman == null) {
        throw Exception('Salesman account was not created');
      }

      // Salesman's UID
      final String salesmanUid = salesman.uid;

      // Save Salesman information to the database
      await salesmanUsers.child(salesmanUid).set({
        'uid': salesmanUid,
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'salesman',
        'ownerId': owner.uid,
      });
    } finally {
      await secondaryAuth.signOut();
      await secondaryApp.delete();
    }
  }

  // ---------------SALESMAN LOGIN---------------

  Future<void> loginSalesman({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);

    final User? user = auth.currentUser;

    if (user == null) {
      throw Exception('Login failed');
    }

    // Check whether this UID exists under salesman
    final DataSnapshot snapshot = await salesmanUsers.child(user.uid).get();

    if (!snapshot.exists) {
      await auth.signOut();

      throw Exception(
        'This account belongs to an owner. Please use the Owner login.',
      );
    }
  }

  // ---------- sign out----------
  Future<void> signOut() async {
    await auth.signOut();
  }
}
