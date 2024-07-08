import 'dart:convert';

import 'package:grocery_app/consts/DIO_package/dio_package.dart';
import 'package:grocery_app/models/album_model.dart';

class UserNetworkService {
  Future<ApiResponse<List<UserModel>>> getListOfUsers() async {
    try {
      var res = await Api().get("albums/2",
          queryParameters: {}, options: null, addRequestInterceptor: false);
      var apiRes = ApiResponse<List<UserModel>>.fromJson(
          res.data,
          (p) => (p as List)
              .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList());
      return apiRes;
    } catch (err) {
      print(err);
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

      print("album  ${res.data}"); 
      var correctData = Album.fromJson(res.data);

      print("album body 22 ${correctData}");
      var apiRes = ApiResponse<Album>(
        success: true,
        message: "Success",
        data: correctData,
      );

      return apiRes;
 
    } catch (err) {
      print(err);
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
