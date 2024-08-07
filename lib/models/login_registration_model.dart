class Login {
  // final String name;
  // final String email;

  final String firstName;
  final String lastName;
  final String email;
  final String userDeviceGUID;
  final String access_token;
  

  Login(this.firstName, this.lastName, this.email, this.userDeviceGUID, this.access_token);

  Login.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        email = json['email'] as String,
        userDeviceGUID = json['userDeviceGUID'] as String,
        access_token = json['access_token'] as String;

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userDeviceGUID': userDeviceGUID,
        'access_token': access_token,
      };   
} 

class AccountConfirmation { 

  final String Username;
  final String Password; 

  AccountConfirmation(this.Username, this.Password);

  AccountConfirmation.fromJson(Map<String, dynamic> json)
      : Username = json['Username'] as String,
        Password = json['Password'] as String;

  Map<String, dynamic> toJson() => {
        'Username': Username,
        'Password': Password, 
      };   
} 
