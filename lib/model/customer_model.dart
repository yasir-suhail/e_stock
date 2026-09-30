class CustomerModel {
  final String id;
  final String name;
  final String address;
  final String phone;

  CustomerModel({required this.id, required this.name, required this.address,required this.phone});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'address': address,'phone': phone};
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone']?? ''
    );
  }
}
