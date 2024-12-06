class UserModel {
  String name;
  String username;
  String website;
  String email;
  Address address;
  String phone;
  String company;

  UserModel({
    required this.name,
    required this.username,
    required this.website,
    required this.email,
    required this.address,
    required this.phone,
    required this.company,
  });

  factory UserModel.fromAPI({required Map<String, dynamic> data}) {
    Address rawAddress = Address.fromAPI(data: data["address"]);
    return UserModel(
      name: data["name"].toString(),
      username: data["username"].toString(),
      website: data["website"].toString(),
      email: data["email"].toString(),
      address: rawAddress,
      phone: data["phone"].toString(),
      company: data["company"]["name"].toString(),
    );
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });
  factory Address.fromAPI({required Map<String, dynamic> data}) {
    return Address(
      street: data["street"].toString(),
      suite: data["suite"].toString(),
      city: data["city"].toString(),
      zipcode: data["zipcode"].toString(),
    );
  }
}
