
// import 'dart:async';
// import 'dart:io';

// import 'package:dio/dio.dart';

// class ConstantsRestApi {
   

//    final dio = createDio();
//   String _token = "";
//   String _apiKey = "";

//   Api._internal();

//   static final _singleton = Api._internal();

//   factory Api() => _singleton;

//   static Dio createDio() {
//     var dio = Dio(BaseOptions(
//       baseUrl: "YOUR BASE URL HERE", //For example : https:www.example.com
//       connectTimeout: 30000,
//       //30 secs
//       receiveTimeout: 30000,
//       //30 secs
//       sendTimeout: 30000,
//       //20secs
//     ));
//     dio.interceptors.addAll({ErrorInterceptor(dio)});
//     return dio;
//   }

//   String get token => _token;

//   set token(String? value) {
//     if (value != null && value.isNotEmpty) {
//       _token = value;
//     }
//   }

//   String get apiKey => _apiKey;

//   set apiKey(String? value) {
//     if (value != null && value.isNotEmpty) {
//       _apiKey = value;
//     }
//   }

//   clearKeyToken() {
//     _token = "";
//     _apiKey = "";
//   }

//   ///[GET] We will use this method inorder to process get requests
// //   Future<Response> get(
// //     String path, {
// //     Map<String, dynamic>? queryParameters,
// //     Options? options,
// //     CancelToken? cancelToken,
// //     void Function(int, int)? onReceiveProgress,
// //     bool addRequestInterceptor = true,
// //   }) async {
// //     print("GETTING API FROM : ${this.dio.options.baseUrl + path}");
// //     if (addRequestInterceptor) {
// //       dio.interceptors
// //           .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
// //     }
// //     print("QUERY PARAMS=>${queryParameters}");
// //     return await dio.get(this.dio.options.baseUrl + path,
// //         onReceiveProgress: onReceiveProgress,
// //         cancelToken: cancelToken,
// //         options: options,
// //         queryParameters: queryParameters);
// //   }

// //   ///[POST] We will use this method inorder to process post requests
// //   Future<Response> post(
// //     String path, {
// //     dynamic data,
// //     Map<String, dynamic>? queryParameters,
// //     Options? options,
// //     CancelToken? cancelToken,
// //     void Function(int, int)? onSendProgress,
// //     void Function(int, int)? onReceiveProgress,
// //     bool addRequestInterceptor = true,
// //   }) async {
// //     print("URL : ${this.dio.options.baseUrl + path}");
// //     print("Request body : ${data}");
// //     if (addRequestInterceptor) {
// //       dio.interceptors
// //           .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
// //     }
// //     return await dio.post(this.dio.options.baseUrl + path,
// //         data: FormData.fromMap(data),
// //         queryParameters: queryParameters,
// //         options: options,
// //         cancelToken: cancelToken,
// //         onReceiveProgress: onReceiveProgress,
// //         onSendProgress: onSendProgress);
// //   }



// // class ErrorInterceptor extends Interceptor {
// //   final Dio dio;

// //   ErrorInterceptor(this.dio);

// //   @override
// //   void onError(DioError err, ErrorInterceptorHandler handler) {
// //     switch (err.type) {
// //       case DioErrorType.connectTimeout:
// //         throw ConnectionTimeOutException(err.requestOptions);
// //       case DioErrorType.sendTimeout:
// //         throw SendTimeOutException(err.requestOptions);
// //       case DioErrorType.receiveTimeout:
// //         throw ReceiveTimeOutException(err.requestOptions);
// //       case DioErrorType.response:
// //         print("STATUS CODE : ${err.response?.statusCode}");
// //         print("${err.response?.data}");
// //         switch (err.response?.statusCode) {
// //           case 400:
// //             throw BadRequestException(err.requestOptions);
// //           case 401:
// //             throw UnauthorizedException(err.requestOptions);
// //           case 404:
// //             throw NotFoundException(err.requestOptions);
// //           case 409:
// //             throw ConflictException(err.requestOptions);
// //           case 500:
// //             throw InternalServerErrorException(err.requestOptions);
// //         }
// //         break;
// //       case DioErrorType.cancel:
// //         // TODO: Handle this case.
// //         break;
// //       case DioErrorType.other:
// //         print(err.message);
// //         throw NoInternetConnectionException(err.requestOptions);
// //     }
// //     return handler.next(err);
// //   }
// // }

// // class RequestInterceptor extends Interceptor {
// //   final Dio dio;
// //   final String apiKey;
// //   final String token;

// //   RequestInterceptor(this.dio, {required this.token, required this.apiKey});

// //   @override
// //   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
// //     options.headers = {'apiKey': apiKey, 'token': token};
// //     return handler.next(options);
// //   }
// // }

// // class ConnectionTimeOutException extends DioError {
// //   ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Connection Timed out, Please try again';
// //   }
// // }

// // class SendTimeOutException extends DioError {
// //   SendTimeOutException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Send Timed out, Please try again';
// //   }
// // }

// // class ReceiveTimeOutException extends DioError {
// //   ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Receive Timed out, Please try again';
// //   }
// // }

// // //**********-----STATUS CODE ERROR HANDLERS--------**********

// // class BadRequestException extends DioError {
// //   BadRequestException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Invalid request';
// //   }
// // }

// // class InternalServerErrorException extends DioError {
// //   InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Internal server error occurred, please try again later.';
// //   }
// // }

// // class ConflictException extends DioError {
// //   ConflictException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Conflict occurred';
// //   }
// // }

// // class UnauthorizedException extends DioError {
// //   UnauthorizedException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'Access denied';
// //   }
// // }

// // class NotFoundException extends DioError {
// //   NotFoundException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'The requested information could not be found';
// //   }
// // }

// // class NoInternetConnectionException extends DioError {
// //   NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

// //   @override
// //   String toString() {
// //     return 'No internet connection detected, please try again.';
// //   }
// // }
// }