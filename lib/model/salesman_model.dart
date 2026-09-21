class SalesmanModel {

  final String uid;
  final String name;
  final String email;
  final String phone;

  final String? ownerId;
  final String? factoryName;

  // Constructor
  SalesmanModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.ownerId,
    this.factoryName,

  });


  // Factory constructor
  // Firebase gives us the salesman data as a Map.
  // This converts:
  // Map<String, dynamic>
  //          ↓
  //    SalesmanModel
  factory SalesmanModel.fromMap(Map<String, dynamic> data) {
    return SalesmanModel(
      // Get the salesman UID from Firebase.
      // If it doesn't exist, use an empty String.
      uid: data['uid'] ?? '',

      // Get the salesman's name.
      name: data['name'] ?? '',

      // Get the salesman's email.
      email: data['email'] ?? '',

      // Get the salesman's phone.
      phone: data['phone'] ?? '',

      // Get the owner's UID connected to this salesman.
      //
      // This is nullable because ownerId may not exist.
      ownerId: data['ownerId'],
      factoryName: data['factoryName'],

    );
  }


  // toMap()
  //
  // Converts the SalesmanModel object back into a Map.
  //
  // This is useful when we want to save/update
  // salesman information in Firebase.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'ownerId': ownerId,
      'factoryName': factoryName,

    };
  }
}