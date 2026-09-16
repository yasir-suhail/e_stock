// This class is the blueprint for Owner data.
//
// It defines what information an Owner object will contain.
class OwnerModel {

  // These are the properties/fields of the Owner.
  //
  // 'final' means their value cannot be reassigned
  // after the object has been created.
  final String uid;
  final String name;
  final String email;
  final String phone;

  // '?' means this value can also be null.
  // An Owner may not have a factoryName in some cases.
  final String? factoryName;


  // Constructor
  //
  // The constructor is used to create an actual OwnerModel object
  // and put values into its fields.
  OwnerModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.factoryName,
  });


  // Factory constructor
  //
  // Firebase gives us data in Map format.
  //
  // This method converts:
  //
  // Map<String, dynamic>
  //          ↓
  //     OwnerModel
  //
  factory OwnerModel.fromMap(Map<String, dynamic> data) {
    return OwnerModel(
      // Get the uid from the Firebase Map.
      // If uid is null, use an empty String.
      uid: data['uid'] ?? '',

      // Get the owner's name.
      name: data['name'] ?? '',

      // Get the owner's email.
      email: data['email'] ?? '',

      // Get the owner's phone.
      phone: data['phone'] ?? '',

      // Get the factory name.
      // It can be null, so we don't use ?? '' here.
      factoryName: data['factoryName'],
    );
  }


  // toMap()
  //
  // This does the opposite of fromMap().
  //
  // It converts:
  //
  // OwnerModel
  //     ↓
  // Map<String, dynamic>
  //
  // The Map can then be saved to Firebase.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'factoryName': factoryName,
    };
  }
}