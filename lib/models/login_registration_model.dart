class Login {
  // final String name;
  // final String email;

  final String firstName;
  final String lastName;
  final String email;

  Login(this.firstName, this.lastName, this.email);

  Login.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'title': email,
      };

   
} 
