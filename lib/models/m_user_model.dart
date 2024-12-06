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



  // {
  //   "id": 1,
  //   "name": "Leanne Graham",
  //   "username": "Bret",
  //   "email": "Sincere@april.biz",
  //   "address": {
  //     "street": "Kulas Light",
  //     "suite": "Apt. 556",
  //     "city": "Gwenborough",
  //     "zipcode": "92998-3874",
  //     "geo": {
  //       "lat": "-37.3159",
  //       "lng": "81.1496"
  //     }
  //   },
  //   "phone": "1-770-736-8031 x56442",
  //   "website": "hildegard.org",
  //   "company": {
  //     "name": "Romaguera-Crona",
  //     "catchPhrase": "Multi-layered client-server neural-net",
  //     "bs": "harness real-time e-markets"
  //   }
  // },

//    profile pic - first letter of their name
// - their name
// - their user name
// - share button - launch to their website on click
// - email
// - address
// - phone
// - company name