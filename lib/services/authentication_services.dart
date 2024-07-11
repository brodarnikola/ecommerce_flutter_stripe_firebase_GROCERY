import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/consts/DIO_package/dio_package.dart';
import 'package:grocery_app/consts/DIO_package/response.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/models/reservations_model.dart';
import 'dart:developer' as developer;

import 'package:grocery_app/models/vehicles_model.dart';

import 'package:dio/dio.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// HARDOCORDED DATA FOR USER brodarnikola60@gmail.com .. Latter we will delete this data

// VERY IMPORTTANT TO GET DATA FROM BACKEND IS GUID OR THIS "userDeviceGUID": "05dd0494-badc-4104-9c33-3bb5849bc9c5",

class AuthenticationServices {

Future<ApiResponse<List<ReservationsModel>>> getReservations(BuildContext context) async {
    try {
      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};

      // String bodyData = json.encode(data);

      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      var res = await Api().get(
          "/getreservations?guid=${sharedPrefState.getGUID}&samoAktivne=1",
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPrefState.getBearerToken}"
             // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 reservations response body is 11  ${res?.data}");

      List<dynamic> jsonData = res?.data;
      List<ReservationsModel> vehicles = ReservationsModel.fromJsonList(jsonData);
      // Now you have a list of Reservatiosn objects
      // You can print or use them as you wish
      for (var vehicle in vehicles) {
        print(vehicle.RotoGarazaNaziv);
      }

      print("22 reservations response body is 22  ${vehicles}");
      // var correctData = VehiclesModel.fromJsonList(res?.data);

      var apiRes = ApiResponse<List<ReservationsModel>>(
        success: true,
        message: "Success",
        data: vehicles,
      );
 
      apiRes.data.forEach((element) {
        print("vehicles body ${element}");
      }); 

      // [
//     {
//         "RezervacijaID": 75,
//         "RotoGarazaID": 18,
//         "TipSlotID": 1,
//         "TipSlotNaziv": "Rezervacija - bez punjača",
//         "RotoGarazaNaziv": "Garaža Zagreb",
//         "Registracija": "ck201gl",
//         "Pocetak": "2024-07-11T09:00:00",
//         "Kraj": "2024-07-11T10:00:00",
//         "PlaceniIznos": 93
//     }
// ]

      return apiRes;
    } catch (err) {
      print("Catched reservation exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<List<CreditCardsModel>>> getCreditCards(BuildContext context) async {
    try {
      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};

      // String bodyData = json.encode(data);
 
      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      var res = await Api().get(
          "/UserDeviceCard/GetAllByUserDeviceID?guid=${sharedPrefState.getGUID}",
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPrefState.getBearerToken}" // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 credit cards response body is 11  ${res?.data}");

      List<dynamic> jsonData = res?.data;
      List<CreditCardsModel> vehicles = CreditCardsModel.fromJsonList(jsonData);
      // Now you have a list of VehiclesModel objects
      // You can print or use them as you wish
      for (var vehicle in vehicles) {
        print(vehicle.MaskedCreditCardNumber);
      }

      print("22 credit cards response body is 22  ${vehicles}");
      // var correctData = VehiclesModel.fromJsonList(res?.data);

      var apiRes = ApiResponse<List<CreditCardsModel>>(
        success: true,
        message: "Success",
        data: vehicles,
      );

      // print("vehicles body ${apiRes.data}");
      apiRes.data.forEach((element) {
        print("vehicles body ${element}");
      });
      // var apiRes = ApiResponse<VehiclesModel>(
      //   success: true,
      //   message: "Success",
      //   data: Object(),
      // );

      // [{UserDeviceVehicleID: 55, UserDeviceID: 24, Name: RENALUT LAGUNA 1, Ticket: CK100GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:10.15, Message: null, ErrorMessage: null, Success: 0},
      // {UserDeviceVehicleID: 56, UserDeviceID: 24, Name: RENALUT LAGUNA 2, Ticket: CK101GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:20.73, Message: null, ErrorMessage: null, Success: 0}]

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Object>> deleteCreditCard(
      int userDeviceCardID, BuildContext context) async {
    try {
      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      Map data = {
        'UserDeviceCardID': userDeviceCardID,
        'UserDeviceGUID': sharedPrefState.getGUID
      };

      String bodyData = json.encode(data);

      developer.log(bodyData);

      var res = await Api().post("/UserDeviceCard/Delete",
          data: bodyData,
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPrefState.getBearerToken}"
            // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 credit card response body is 11  ${res?.data}");

      var apiRes = ApiResponse<Object>(
        success: true,
        message: "Success",
        data: Object(),
      );

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<List<VehiclesModel>>> getVehicles(
      BuildContext context) async {
    try {
      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};

      // String bodyData = json.encode(data);

      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      var res = await Api().get(
          "/UserDeviceVehicle/GetAllByUserDeviceGUID?guid=5a60acc2-69ad-487b-b73d-91f095f52f8e",
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${sharedPrefState.getBearerToken}" // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 vehicles response body is 11  ${res?.data}");

      List<dynamic> jsonData = res?.data;
      List<VehiclesModel> vehicles = VehiclesModel.fromJsonList(jsonData);
      // Now you have a list of VehiclesModel objects
      // You can print or use them as you wish
      for (var vehicle in vehicles) {
        print(vehicle.Name);
      }

      print("22 vehicles response body is 22  ${vehicles}");
      // var correctData = VehiclesModel.fromJsonList(res?.data);

      var apiRes = ApiResponse<List<VehiclesModel>>(
        success: true,
        message: "Success",
        data: vehicles,
      );

      // print("vehicles body ${apiRes.data}");
      apiRes.data.forEach((element) {
        print("vehicles body ${element}");
      });
      // var apiRes = ApiResponse<VehiclesModel>(
      //   success: true,
      //   message: "Success",
      //   data: Object(),
      // );

      // [{UserDeviceVehicleID: 55, UserDeviceID: 24, Name: RENALUT LAGUNA 1, Ticket: CK100GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:10.15, Message: null, ErrorMessage: null, Success: 0},
      // {UserDeviceVehicleID: 56, UserDeviceID: 24, Name: RENALUT LAGUNA 2, Ticket: CK101GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:20.73, Message: null, ErrorMessage: null, Success: 0}]

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<VehiclesModel>> addOrUpdateVehicle(
      String name,
      String plateNumber,
      int userDeviceVehicleID,
      bool isNewVehicle,
      BuildContext context) async {
    try {
      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      Map data = {
        'Ticket': plateNumber,
        'UserDeviceGUID': sharedPrefState.getGUID,
        'UserDeviceVehicleID': userDeviceVehicleID,
        'Name': name,
      };

      late String url;
      if (isNewVehicle) {
        url = "/UserDeviceVehicle/Add";
      } else {
        url = "/UserDeviceVehicle/Update";
      }

      String bodyData = json.encode(data);

      developer.log(bodyData);

      var res = await Api().post(url,
          data: bodyData,
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${sharedPrefState.getBearerToken}" // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 vehicles add or update response body is 11  ${res.data}");

      var correctData = VehiclesModel.fromJson(res.data);

      var apiRes = ApiResponse<VehiclesModel>(
          success: true, message: "Success", data: correctData);

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Object>> deleteVehicle(
      String ticket, int userDeviceVehicleID, BuildContext context) async {
    try {
      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      Map data = {
        'Ticket': ticket,
        'GUID': sharedPrefState.getEmail,
        'UserDeviceVehicleID': userDeviceVehicleID,
        'LangID': 1,
      };

      String bodyData = json.encode(data);

      developer.log(bodyData);

      var res = await Api().post("/UserDeviceVehicle/Delete",
          data: bodyData,
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${sharedPrefState.getBearerToken}" // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 vehicles response body is 11  ${res?.data}");

      var apiRes = ApiResponse<Object>(
        success: true,
        message: "Success",
        data: Object(),
      );

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }
}
