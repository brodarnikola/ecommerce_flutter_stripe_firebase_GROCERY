import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const THEME_STATUS = "THEMESTATUS";

  static const String IS_LOGGED_IN = "isLoggedIn";

  static const String USERNAME_SP = "username";
  static const String EMAIL_SP = "email";

  static const String PASSWORD = "password";

  static const String GUID = "guid";

  static const String BEARER_TOKEN = "bearer_token";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setIsLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGGED_IN, value);
  }

  Future<bool> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USERNAME_SP, value);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAME_SP) ?? "";
  }

  setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL_SP, value);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EMAIL_SP) ?? "";
  }

  setPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PASSWORD, value);
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PASSWORD) ?? "";
  }

  setGUID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GUID, value);
  }

  Future<String> getGUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GUID) ?? "";
  }

  setBearerToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(BEARER_TOKEN, value);
  }

  Future<String> getBearerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BEARER_TOKEN) ?? "";
  }
}
