import 'dart:convert';
import 'dart:io';
import 'package:grocery_app/consts/DIO_package/dio_package.dart';
import 'package:grocery_app/models/album_model.dart';

class UserNetworkService {
  Future<ApiResponse<List<Album>>> getListOfUsers() async {
    try {
      var res = await Api().get("/albums",
          queryParameters: {}, options: null, addRequestInterceptor: false);

      var albumList = Album.fromJsonList(res?.data);

      // print("album body 00");
      // var albumList = Album.fromJsonList([res.data]);
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
      // if (err is NotFoundException) {
      //   print("DioError: ${err.message}");
      //   print("DioError response data: ${err.response?.data}");
      //   print("DioError response status code: ${err.response?.statusCode}");
      // } else {
      //   print("Catched exception is $err");
      // }
      // print(err);
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
