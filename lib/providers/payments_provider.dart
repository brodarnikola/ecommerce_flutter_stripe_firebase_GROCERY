
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/models/reservations_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class PaymentsProvider with ChangeNotifier {
  static List<ReservationsModel> _payments = [];
  List<ReservationsModel> get getPayments {
    return _payments;
  }  
  
  Future<void> fetchPayments(BuildContext context) async {
   var response = await AuthenticationServices().getPayments(context);

    log("credit cards  ${response}");
    if (response.success && response.data != null) {
      log("credit cards body ${response.data}");
      _payments.addAll(response.data);
    }
    notifyListeners();
  }
}
