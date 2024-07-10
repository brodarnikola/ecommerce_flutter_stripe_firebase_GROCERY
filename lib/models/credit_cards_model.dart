import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CreditCardsModel with ChangeNotifier {
  final int UserDeviceCardID, UserDeviceID, CardTypeID, ExpirationNotificationID, PGCreditCardBrandID, Success;
  final String ExpirationDate; 
  // DateTimeCreated;

  final String? Message, UserDeviceGUID, ErrorMessage;

  final String Modified, Token, TokenNumber, TokenExp, MaskedCreditCardNumber;
  // final Timestamp orderDate;

  CreditCardsModel(
      this.UserDeviceCardID,
      this.UserDeviceID,
      this.CardTypeID,
      this.ExpirationNotificationID,
      this.PGCreditCardBrandID,
      this.Success,
      this.Modified,
      this.Token,
      this.TokenNumber,
      this.TokenExp,
      this.MaskedCreditCardNumber,
      this.ExpirationDate,
      this.UserDeviceGUID,

      // this.DateTimeCreated,

      this.Message,
      this.ErrorMessage
      // this.orderDate
      );

  CreditCardsModel.fromJson(Map<String, dynamic> json)
      : UserDeviceCardID = json['UserDeviceCardID'] as int,
        UserDeviceID = json['UserDeviceID'] as int,
        CardTypeID = json['CardTypeID'] as int,
        ExpirationNotificationID = json['ExpirationNotificationID'] as int,
        PGCreditCardBrandID = json['PGCreditCardBrandID'] as int,
        Success = json['Success'] as int,
        Modified = json['Modified'] as String,
        Token = json['Token'] as String,
        TokenNumber = json['TokenNumber'] as String,
        TokenExp = json['TokenExp'] as String,
        MaskedCreditCardNumber = json['MaskedCreditCardNumber'] as String,
        ExpirationDate = json['ExpirationDate'] as String,
        UserDeviceGUID = json['UserDeviceGUID'] != null ? json['UserDeviceGUID'] as String : null,

        // DateTimeCreated = json['DateTimeCreated'] as String,

        Message = json['Message'] != null ? json['Message'] as String : null,
        ErrorMessage = json['ErrorMessage'] != null ? json['ErrorMessage'] as String : null;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'UserDeviceCardID': UserDeviceCardID,
        'UserDeviceID': UserDeviceID,
        'CardTypeID': CardTypeID,
        'ExpirationNotificationID': ExpirationNotificationID, 
        'PGCreditCardBrandID': PGCreditCardBrandID, 
        'Success': Success,
        'Modified': Modified,
        'Token': Token,
        'TokenNumber': TokenNumber,
        'TokenExp': TokenExp,
        'MaskedCreditCardNumber': MaskedCreditCardNumber,
        'ExpirationDate': ExpirationDate,
        'UserDeviceGUID': UserDeviceGUID,

        // 'DateTimeCreated': DateTimeCreated,

        'Message': Message,
        'ErrorMessage': ErrorMessage, 
        // 'orderDate': orderDate,
      };

// grant_type=password&source=mobileapp&username=ipavelic1%40gmail.com&password=TestirajMe76!&uuid=ipavelic1%40gmail.com&
// deviceOS=Browser&
// notificationRegID=eyJt_vSrRu2sxIQkTK_GSn%3AAPA91bGcxo7a2MvikhTta22e63R7696Z0hxv7hLbVHULjLmaSwN_OovuBRYWuBmXNtXcFHU4rmAhDHllSGWrymvgcxOvBt5axMo66CO1CI1VaMNnZF5lfXL6QM5-kJgBBAR9Y7j3up1M&
// languageID=1

// [{UserDeviceCardID: 30, UserDeviceGUID: 00000000-0000-0000-0000-000000000000, UserDeviceID: 23, ExpirationDate: 2025-12-31T00:00:00, CardTypeID: 2, ExpirationNotificationID: 386, Modified: 2024-07-10T14:15:33.573, 
// Token: 8b9c5084-79af-43ba-aba8-46128107702c, TokenNumber: 9023, TokenExp: 2512, PGCreditCardBrandID: 7, MaskedCreditCardNumber: 457418------9023, Message: null, ErrorMessage: null, Success: 0}]

  static List<CreditCardsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => CreditCardsModel.fromJson(item as Map<String, dynamic>)).toList();
  }
} 

// [ 
//   { 
//     "UserDeviceCardID": 1,   -----
//     "UserDeviceGUID": "39eda686-aa1d-4443-b752-ef9e50d42b6d",  -----
//     "UserDeviceID": 3,  -----
//     "ExpirationDate": "2024-05-13T11:40:22.8013768+02:00",  -----
//     "CardTypeID": 4,  -----
//     "ExpirationNotificationID": 1,  -----
//     "Modified": "2024-05-13T11:40:22.8013768+02:00",   -----
//     "Token": "sample string 6",   --------
//     "TokenNumber": "sample string 7",  -------
//     "TokenExp": "sample string 8",  --------
//     "PGCreditCardBrandID": 1,  -----
//     "MaskedCreditCardNumber": "sample string 9",   ------
//     "Message": "sample string 10",   ----- 
//     "ErrorMessage": "sample string 11",   ------
//     "Success": 12  -----
//   } 
// ] 

//  [{UserDeviceVehicleID: 55, UserDeviceID: 24, Name: RENALUT LAGUNA 1, Ticket: CK100GL, UserDeviceGUID: null, DateTimeCreated: 2024-07-09T17:17:10.15, Message: null, ErrorMessage: null, Success: 0},