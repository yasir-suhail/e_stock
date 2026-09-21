class OwnerModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? factoryName;
  // Constructor
  OwnerModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.factoryName,
  });


  // Factory constructor
  // Firebase gives us data in Map format.
  // This method converts:
  // Map<String, dynamic>
  //          ↓
  //     OwnerModel

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
  // This does the opposite of fromMap().
  // It converts:
  // OwnerModel
  // Map<String, dynamic>
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