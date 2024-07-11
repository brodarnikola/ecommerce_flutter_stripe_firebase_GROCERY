
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/models/reservations_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class ReservationsProvider with ChangeNotifier {
  static List<ReservationsModel> _reservations = [];
  List<ReservationsModel> get getReservations {
    return _reservations;
  }  
  
  Future<void> fetchReservations(BuildContext context) async {
   var response = await AuthenticationServices().getReservations(context);

    log("credit cards  ${response}");
    if (response.success && response.data != null) {
      log("credit cards body ${response.data}");
      _reservations.addAll(response.data);
    }
    notifyListeners();
  }
}
