import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/consts/DIO_package/dio_package.dart';
import 'package:grocery_app/consts/DIO_package/response.dart';
import 'dart:developer' as developer;

import 'package:grocery_app/models/vehicles_model.dart';

import 'package:dio/dio.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// HARDOCORDED DATA FOR USER brodarnikola60@gmail.com .. Latter we will delete this data

// VERY IMPORTTANT TO GET DATA FROM BACKEND IS GUID OR THIS "userDeviceGUID": "05dd0494-badc-4104-9c33-3bb5849bc9c5",

class AuthenticationServices {
  Future<ApiResponse<List<VehiclesModel>>> getVehicles() async {
    try {
      // Map data = {'Mail': username, 'MailMessage': "Password recovery token"};

      // String bodyData = json.encode(data);

      var res = await Api().get(
          "/UserDeviceVehicle/GetAllByUserDeviceGUID?guid=05dd0494-badc-4104-9c33-3bb5849bc9c5",
          queryParameters: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer SMmbBOkpl6DN7vYTQ-OAd1XBPRcsb2ZV2802-KNQ8Xak90zqmI09Krlv2XtM37atAJO2f9LB0qakV6bbQmDd1LyJG0_TO4NgE-4mt0Kz27iZ0fDfJVDIIb2695xcIldvFRCO9upUcxf0xQw9vS3BlHcZ9NqPZMvTyPIQWBlHiwMaumsahVSlMmOfhOX0OFPirMMWkaD8g8af-FqmT60DxFYpc-R7plibBaEXa_coq7DlbOSiX_9DbMpE-4X42Hg5wIS5r_4d4nUBj9LY9oRLI10SMbxTw1IocLKufiCV-eqj4Na4_KwWVdd0HSkH-r7yVho-ZD51ZuaybURkuo6Jseu-jOlg5QAGIJU7CvfUS42rEBTD-FVukeOkjvEJQWd9jGEn016U2i7bUrUBnrxpxx3Qfm0uRTerDJFHK8vcNXEySahfqBZzpOkte1uuiHWOEJ7jYKLF8UBC2lsmLXwvrZFniRodA-rHVAItGSd70FM"
            // "Bearer $token",
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

  Future<ApiResponse<VehiclesModel>> addOrUpdateVehicle(String name, String plateNumber, int userDeviceVehicleID, bool isNewVehicle, BuildContext context) async {
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
      if(isNewVehicle) {
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
                "Bearer SMmbBOkpl6DN7vYTQ-OAd1XBPRcsb2ZV2802-KNQ8Xak90zqmI09Krlv2XtM37atAJO2f9LB0qakV6bbQmDd1LyJG0_TO4NgE-4mt0Kz27iZ0fDfJVDIIb2695xcIldvFRCO9upUcxf0xQw9vS3BlHcZ9NqPZMvTyPIQWBlHiwMaumsahVSlMmOfhOX0OFPirMMWkaD8g8af-FqmT60DxFYpc-R7plibBaEXa_coq7DlbOSiX_9DbMpE-4X42Hg5wIS5r_4d4nUBj9LY9oRLI10SMbxTw1IocLKufiCV-eqj4Na4_KwWVdd0HSkH-r7yVho-ZD51ZuaybURkuo6Jseu-jOlg5QAGIJU7CvfUS42rEBTD-FVukeOkjvEJQWd9jGEn016U2i7bUrUBnrxpxx3Qfm0uRTerDJFHK8vcNXEySahfqBZzpOkte1uuiHWOEJ7jYKLF8UBC2lsmLXwvrZFniRodA-rHVAItGSd70FM"
            // "Bearer $token",
          }),
          addRequestInterceptor: false,
          cancelToken: null,
          onReceiveProgress: (p0, p1) => {});

      print("11 vehicles add or update response body is 11  ${res.data}"); 

       var correctData = VehiclesModel.fromJson(res.data);

      var apiRes = ApiResponse<VehiclesModel>(
        success: true,
        message: "Success",
        data: correctData
      ); 

      return apiRes;
    } catch (err) {
      print("Catched vehicle exception is $err");
      throw Exception(err.toString());
    }
  }

  Future<ApiResponse<Object>> deleteVehicle(String ticket, int userDeviceVehicleID, BuildContext context) async {
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
                "Bearer SMmbBOkpl6DN7vYTQ-OAd1XBPRcsb2ZV2802-KNQ8Xak90zqmI09Krlv2XtM37atAJO2f9LB0qakV6bbQmDd1LyJG0_TO4NgE-4mt0Kz27iZ0fDfJVDIIb2695xcIldvFRCO9upUcxf0xQw9vS3BlHcZ9NqPZMvTyPIQWBlHiwMaumsahVSlMmOfhOX0OFPirMMWkaD8g8af-FqmT60DxFYpc-R7plibBaEXa_coq7DlbOSiX_9DbMpE-4X42Hg5wIS5r_4d4nUBj9LY9oRLI10SMbxTw1IocLKufiCV-eqj4Na4_KwWVdd0HSkH-r7yVho-ZD51ZuaybURkuo6Jseu-jOlg5QAGIJU7CvfUS42rEBTD-FVukeOkjvEJQWd9jGEn016U2i7bUrUBnrxpxx3Qfm0uRTerDJFHK8vcNXEySahfqBZzpOkte1uuiHWOEJ7jYKLF8UBC2lsmLXwvrZFniRodA-rHVAItGSd70FM"
            // "Bearer $token",
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
