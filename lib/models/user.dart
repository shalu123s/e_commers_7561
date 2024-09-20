
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final List<Address> addresses;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.addresses = const [],
  });

  // Factory constructor to create an AppUser from a map (e.g., from Firebase)
  factory AppUser.fromMap(Map<String, dynamic> map, String documentId) {
    return AppUser(
      id: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      addresses: map['addresses'] != null
          ? List<Address>.from(
              map['addresses'].map((address) => Address.fromMap(address)),
            )
          : [],
    );
  }

  // Method to convert an AppUser to a map (e.g., for uploading to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'addresses': addresses.map((address) => address.toMap()).toList(),
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  // Factory constructor to create an Address from a map
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      country: map['country'] ?? '',
    );
  }

  // Method to convert an Address to a map
  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }
}
