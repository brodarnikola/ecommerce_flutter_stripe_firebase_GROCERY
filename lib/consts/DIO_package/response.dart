import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:grocery_app/consts/DIO_package/dio_package.dart';
import 'package:grocery_app/models/album_model.dart';
import 'dart:developer' as developer;

import 'package:grocery_app/models/login_registration_model.dart';

class UserNetworkService {

   Future<ApiResponse<Object>> accountConfirmation(String username, String confirmationCode) async {
    try {
      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};
    
      // String bodyData = json.encode(data);

      developer.log("username is $username");
      developer.log("confirmationCode is $confirmationCode");

       var res = await Api().get("/activateaccount?Username=$username&ActivationCode=$confirmationCode", // + activationModel.Username + "&ActivationCode=" + activationModel.confirmationCode,, // Api().get("/UserResetPasswordRequest", 
          queryParameters: {},
          options: null,
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      var apiRes = ApiResponse<Object>(
        success: true,
        message: "Success",
        data: Object(),
      );

      return apiRes;
    } catch (err) {
      print("Catched exception is $err");
      throw Exception(err.toString());
    }
  }

   Future<ApiResponse<Object>> registerNewUser(String email, String password, String fullName, String address) async {
    try {

        Map data = {
          'Username': email,
          'Email': email,
          'Password': password,
          'Name': fullName,
          'Surname': " Awesome",
          'Address': address,
          'City': address,
          'Zip': address,
          'State': address,
          'Phone': address, 
          'OIB': "",
          'EmailNotificationTypeID': 1,
          'LanguageID': 1,
          'DeviceOS': "android",
        };

      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};
    
      String bodyData = json.encode(data);

      developer.log(bodyData);

       var res = await Api().post("/registeruser",
          data: bodyData, 
          queryParameters: {},
          options: null,
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      var apiRes = ApiResponse<Object>(
        success: true,
        message: "Success",
        data: Object(),
      );

      return apiRes;
    } catch (err) {
      print("Catched registration exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Object>> forgotPassword(String username) async {
    try {
      Map data = {'Mail': username, 'MailMessage': "Password recovery token"};
    
      String bodyData = json.encode(data);

      developer.log(bodyData);

       var res = await Api().post("/UserResetPasswordRequest",
          data: bodyData, 
          queryParameters: {},
          options: null,
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      var apiRes = ApiResponse<Object>(
        success: true,
        message: "Success",
        data: Object(),
      );

      return apiRes;
    } catch (err) {
      print("Catched exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Login>> loginUser(String username, String password) async {
    try {
      Map<String, String> loginData = {
        "grant_type": "password",
        "source": "mobileapp",
        'username': username,
        'password': password,
        'uuid':
            username, // "87f05e5908172913", // "e751f0284458d01d", // database.get("DeviceUUID"), // --> e751f0284458d01d  za account ipavelic1@gmail.com
        "deviceOS": "android",
        "notificationRegID":
            "eyJt_vSrRu2sxIQkTK_GSn%3AAPA91bGcxo7a2MvikhTta22e63R7696Z0hxv7hLbVHULjLmaSwN_OovuBRYWuBmXNtXcFHU4rm",
        "languageID": "1"
      };

      String loginRequestText =
          loginData.entries.map((e) => '${e.key}=${e.value}').join('&');

      developer.log(loginRequestText);

      var res = await Api().post("/token",
          data: loginRequestText, 
          queryParameters: {},
          options: null,
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      var correctData = Login.fromJson(res.data);

      var apiRes = ApiResponse<Login>(
        success: true,
        message: "Success",
        data: correctData,
      );

      return apiRes;
    } catch (err) {
      print("Catched exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<List<Album>>> getListOfUsers() async {
    try {
      var res = await Api().get("/albums",
          queryParameters: {}, options: null, addRequestInterceptor: false);

      var albumList = Album.fromJsonList(res?.data);

      albumList.forEach((album) {
        print(
            'userId: ${album.userId}, id: ${album.id}, title: ${album.title}');
      });

      print("album body 11 ${albumList}");
      print("album body 22 ${albumList.join("\n")}");
      var apiRes = ApiResponse<List<Album>>(
        success: true,
        message: "Success",
        data: albumList,
      );

      return apiRes;
    } catch (err) {
      print("22 Catched exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Album>> getListOfUser2() async {
    try {
      var res = await Api().get("/albums/2",
          queryParameters: {},
          options: null,
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("album  ${res?.data}");
      var correctData = Album.fromJson(res?.data);

      print("album body 22 ${correctData}");
      var apiRes = ApiResponse<Album>(
        success: true,
        message: "Success",
        data: correctData,
      );

      return apiRes;
    } catch (err) {
      print("Catched exception is $err");
      throw Exception(err.toString());
    }
  }
}

class ApiResponse<T> {
  bool success;
  String message;
  T data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      success: json['success'] ??
          false, // provide a default value in case json['success'] is null
      message: json['message'] ??
          '', // provide a default value in case json['message'] is null
      data: fromJsonT(json['data']),
    );
  }
}

class UserModel {
  int id;
  String name;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
