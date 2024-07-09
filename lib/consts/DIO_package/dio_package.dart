import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grocery_app/consts/constants.dart';

class Api {
  final dio = createDio();
  String _token = "";
  String _apiKey = "";

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Constants.BASE_URL, //For example : https:www.example.com
      //15 secs
      connectTimeout: const Duration(milliseconds: 15000),
      //15 secs
      receiveTimeout: const Duration(milliseconds: 15000),
      //15 secs
      sendTimeout: const Duration(milliseconds: 15000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
    ));
    dio.interceptors.addAll({ErrorInterceptor(dio)});
    return dio;
  }

  String get token => _token;

  set token(String? value) {
    if (value != null && value.isNotEmpty) {
      _token = value;
    }
  }

  String get apiKey => _apiKey;

  set apiKey(String? value) {
    if (value != null && value.isNotEmpty) {
      _apiKey = value;
    }
  }

  clearKeyToken() {
    _token = "";
    _apiKey = "";
  }

  ///[GET] We will use this method inorder to process get requests
  Future<Response?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    try {
      print("GETTING API FROM : ${this.dio.options.baseUrl + path}");
      if (addRequestInterceptor) {
        dio.interceptors
            .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
      }
      print("QUERY PARAMS=>${queryParameters}");
      return await dio.get(this.dio.options.baseUrl + path,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          options: options,
          queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(handleErrorException(e));
    } catch (err) {
      print("Error in get request: $err");
      // Handle other exceptions here or rethrow
      throw err;
    }
  }

  ///[POST] We will use this method inorder to process post requests
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
    // bool isLoginRequest = false
  }) async {
    try {
      print("URL : ${this.dio.options.baseUrl + path}");
      print("Request body : ${data}");
      if (addRequestInterceptor) {
        dio.interceptors
            .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
      }

      // Object finalData = Object();
      // if(isLoginRequest) {
      //   finalData = data;
      // } else {
      //   finalData = FormData.fromMap(data);
      // };

      return await dio.post(this.dio.options.baseUrl + path,
          data: data, // finalData, // FormData.fromMap(data),
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
    } on DioException catch (e) {
      throw Exception(handleErrorException(e));
    } catch (err) {
      print("Error in get request: $err");
      // Handle other exceptions here or rethrow
      throw err;
    }
  } 
}

class RequestInterceptor extends Interceptor {
  final Dio dio;
  final String apiKey;
  final String token;

  RequestInterceptor(this.dio, {required this.token, required this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {'apiKey': apiKey, 'token': token};
    return handler.next(options);
  }
}

DioException handleErrorException(DioException e) {
  if (e.type == DioExceptionType.badResponse) {
    if (e.response?.statusCode == 400) {
      print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
      throw BadRequestException(e.requestOptions);
    } else if (e.response?.statusCode == 401) {
      print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
      throw UnauthorizedException(e.requestOptions);
    } else if (e.response?.statusCode == 404) {
      print("404 error: ${e.response?.data}");
      throw NotFoundException(e.requestOptions);
    } else if (e.response?.statusCode == 409) {
      print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
      throw ConflictException(e.requestOptions);
    } else if (e.response?.statusCode == 500) {
      print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
      throw InternalServerErrorException(e.requestOptions);
    } else {
      print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
      throw Exception(e.response?.data);
    }
  } else if (e.type == DioExceptionType.receiveTimeout) {
    print("Receive timeout error");
    throw ReceiveTimeOutException(e.requestOptions);
  } else if (e.type == DioExceptionType.connectionTimeout) {
    print("Connection timeout error");
    throw ConnectionTimeOutException(e.requestOptions);
  } else if (e.type == DioExceptionType.sendTimeout) {
    print("Send timeout error");
    throw SendTimeOutException(e.requestOptions);
  } else if (e.type == DioExceptionType.connectionError) {
    if (e.error is SocketException) {
      print("No internet connection");
      throw NoInternetConnectionException(e.requestOptions);
    } else {
      print("Other error: ${e.message}");
    }
  } else {
    print("Unexpected error: ${e.message}");
  }
  throw e;
}

class ErrorInterceptor extends Interceptor {
  final Dio dio;

  ErrorInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        print("DioExceptionType connection timeout exception");
        break;
      // throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        print("DioExceptionType send timeout exception");
        break;
      // throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        print("DioExceptionType received timeout exception");
        break;
      // throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.badCertificate:
        print("DioExceptionType Bad certificate");
        break;
      case DioExceptionType.badResponse:
        print("STATUS CODE : ${err.response?.statusCode}");
        print("${err.response?.data}");
        switch (err.response?.statusCode) {
          case 400:
            print("DioExceptionType 401 bad request");
            break;
          case 401:
            print("DioExceptionType 401 not authorized");
            break;
          case 404:
            print("DioExceptionType 404 not found");
            break;
          // throw NotFoundException(err.requestOptions).toString();
          case 409:
            print("DioExceptionType 409 conflict exception");
            break;
          case 500:
            print("DioExceptionType 500 server error exception");
            break;
        }
        break;

      case DioExceptionType.cancel:
        print("DioExceptionType Cancel");
        break;
      case DioExceptionType.connectionError:
        print("DioExceptionType connectionError");
        break;
      case DioExceptionType.unknown:
        print("DioExceptionType unknown");
        break;
    }
  }
}

class ConnectionTimeOutException extends DioException {
  ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection Timed out, Please try again';
  }
}

class SendTimeOutException extends DioException {
  SendTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Send Timed out, Please try again';
  }
}

class ReceiveTimeOutException extends DioError {
  ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Receive Timed out, Please try again';
  }
}

//**********-----STATUS CODE ERROR HANDLERS--------**********

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Internal server error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}
