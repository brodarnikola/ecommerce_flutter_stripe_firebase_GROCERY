import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VehiclesModel with ChangeNotifier {
  final int UserDeviceVehicleID, UserDeviceID, Success;
  final String Name, Ticket, DateTimeCreated;
  final String? Message, UserDeviceGUID, ErrorMessage;
  // final Timestamp orderDate;

  VehiclesModel(
      this.UserDeviceVehicleID,
      this.UserDeviceID,
      this.Success,
      this.Name,
      this.Ticket,
      this.UserDeviceGUID,
      this.DateTimeCreated,
      this.Message,
      this.ErrorMessage
      // this.orderDate
      );

  VehiclesModel.fromJson(Map<String, dynamic> json)
      : UserDeviceVehicleID = json['UserDeviceVehicleID'] as int,
        UserDeviceID = json['UserDeviceID'] as int,
        Success = json['Success'] as int,
        Name = json['Name'] as String,
        Ticket = json['Ticket'] as String,
        UserDeviceGUID = json['UserDeviceGUID'] != null ? json['UserDeviceGUID'] as String : null,
        DateTimeCreated = json['DateTimeCreated'] as String,
        Message = json['Message'] != null ? json['Message'] as String : null,
        ErrorMessage = json['ErrorMessage'] != null ? json['ErrorMessage'] as String : null;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'UserDeviceVehicleID': UserDeviceVehicleID,
        'UserDeviceID': UserDeviceID,
        'Success': Success,
        'Name': Name,
        'Ticket': Ticket,
        'UserDeviceGUID': UserDeviceGUID,
        'DateTimeCreated': DateTimeCreated,
        'Message': Message,
        'ErrorMessage': ErrorMessage, 
        // 'orderDate': orderDate,
      };


  static List<VehiclesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => VehiclesModel.fromJson(item as Map<String, dynamic>)).toList();
  }
} 

//  [{UserDeviceVehicleID: 55, UserDeviceID: 24, Name: RENALUT LAGUNA 1, Ticket: CK100GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:10.15, Message: null, ErrorMessage: null, Success: 0},

//  "UserDeviceVehicleID": 1, 
//     "UserDeviceID": 2, 
//     "Name": "sample string 3", 
//     "Ticket": "sample string 4", 
//     "UserDeviceGUID": "sample string 5", 
//     "DateTimeCreated": "2024-05-13T10:59:07.6279713+02:00", 
//     "Message": "sample string 7", 
//     "ErrorMessage": "sample string 8", 
//     "Success": 9
