import 'package:flutter/cupertino.dart';

import '../services/shared_prefs.dart';

class SharedPrefsProvider with ChangeNotifier {
  SharedPrefs darkThemePrefs = SharedPrefs();

  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  bool _isLoggedIn = false;
  bool get getIsLoggedInValue => _isLoggedIn;

  String _usernameSp = "";
  String get getUsername => _usernameSp;

  String _emailSp = "";
  String get getEmail => _emailSp;
 
  String _passwordSP = "";
  String get getPassword => _passwordSP;

  String _guidSP = "";
  String get getGUID => _guidSP;

  String _bearerTokenSP = "";
  String get getBearerToken => _bearerTokenSP;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }

  set setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    darkThemePrefs.setIsLoggedIn(value);
    notifyListeners();
  }

  Future<bool> isLoggedInUser() async {
    bool isLoggedIn = await darkThemePrefs.getIsLoggedIn();
    _isLoggedIn = isLoggedIn;
    return isLoggedIn;
  }

  set setUsername(String value) {
    _usernameSp = value;
    darkThemePrefs.setUsername(value);
    notifyListeners();
  }

  void getUsernameValue() async {
    String usernameValue = await darkThemePrefs.getUsername();
    _usernameSp = usernameValue;
  }

  set setEmail(String value) {
    _emailSp = value;
    darkThemePrefs.setEmail(value);
    notifyListeners();
  }

  void getEmailValue() async {
    String emailValue = await darkThemePrefs.getEmail();
    _emailSp = emailValue;
  }

  set setPassword(String value) {
    _passwordSP = value;
    darkThemePrefs.setPassword(value);
    notifyListeners();
  }

  void getPasswordValue() async {
    String passwordValue = await darkThemePrefs.getPassword();
    _passwordSP = passwordValue;
  }

  set setGUID(String value) {
    _guidSP = value;
    darkThemePrefs.setGUID(value);
    notifyListeners();
  }

  void getGUIDValue() async {
    String guidValue = await darkThemePrefs.getGUID();
    _guidSP = guidValue;
  }

  set setBearerToken(String value) {
    _bearerTokenSP = value;
    darkThemePrefs.setBearerToken(value);
    notifyListeners();
  }

  void getBearerTokenValue() async {
    String bearerTokenValue = await darkThemePrefs.getBearerToken();
    _bearerTokenSP = bearerTokenValue;
  }


}
