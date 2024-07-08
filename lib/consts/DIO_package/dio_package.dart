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
      connectTimeout: const Duration(milliseconds: 15000),
      //30 secs
      receiveTimeout: const Duration(milliseconds: 15000),
      //30 secs
      sendTimeout: const Duration(milliseconds: 15000),
      //20secs
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

      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 404) {
          print("404 error: ${e.response?.data}");
          throw NotFoundException(e.requestOptions);
        } else {
          print("HTTP error: ${e.response?.statusCode}, ${e.response?.data}");
        }
      } else if (e.type == DioExceptionType.connectionError) {
        if (e.error is SocketException) {
          print("No internet connection");
        } else {
          print("Other error: ${e.message}");
        }
      } else {
        print("Unexpected error: ${e.message}");
      }
      throw e;

      // print("DioError in get request: ${dioError.message}");
      // // Handle DioError here or rethrow
      // throw dioError;
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
  }) async {
    print("URL : ${this.dio.options.baseUrl + path}");
    print("Request body : ${data}");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    return await dio.post(this.dio.options.baseUrl + path,
        data: FormData.fromMap(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }
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
        throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        print("DioExceptionType Bad certificate");
        break;
      case DioExceptionType.badResponse:
        print("STATUS CODE : ${err.response?.statusCode}");
        print("${err.response?.data}");
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            print("DioExceptionType connectionError");
            // throw NotFoundException(err.requestOptions).toString();
            break;
          // return NotFoundException(err.requestOptions);
          // throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
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
