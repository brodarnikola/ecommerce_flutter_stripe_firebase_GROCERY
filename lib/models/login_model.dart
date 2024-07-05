class User { 

  // final int userId;
  // final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String zip;
  final String country;

  User(this.username, this.firstName, this.lastName, this.address, this.city, this.zip, this.country);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String,
        firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,

        address = json['address'] as String,
        city = json['city'] as String,
        zip = json['zip'] as String,
        country = json['country'] as String;

  Map<String, dynamic> toJson() => {
        'username': username,
        'firstName': firstName,
        'lastName': lastName,

        'address': address,
        'city': city,
        'zip': zip,
        'country': country,
      };
} 
