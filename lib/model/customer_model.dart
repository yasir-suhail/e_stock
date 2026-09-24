class CustomerModel {
  final String id;
  final String name;
  final String address;

  CustomerModel({required this.id, required this.name, required this.address});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'address': address};
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
