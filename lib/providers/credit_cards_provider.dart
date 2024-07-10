
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class CreditCardsProvider with ChangeNotifier {
  static List<CreditCardsModel> _creditCards = [];
  List<CreditCardsModel> get getCreditCards {
    return _creditCards;
  }

  void clearVehicles() {
    _creditCards.clear();
    notifyListeners();
  }

  void deleteVehicle(int index) {
    _creditCards.removeAt(index);
    notifyListeners();
  }

  void addVehicle(CreditCardsModel data) {
    _creditCards.add(data);
    notifyListeners();
  }

  void updateVehicle(CreditCardsModel data) {
    // int index = _vehicles.indexWhere((element) =>
    //     element.UserDeviceVehicleID == data.UserDeviceVehicleID );
    // _vehicles[index] = data;
    notifyListeners();
  }

  Future<void> fetchCreditCards() async {
   var response = await AuthenticationServices().getCreditCards();

    log("credit cards  ${response}");
    if (response.success && response.data != null) {
      log("credit cards body ${response.data}");
      _creditCards.addAll(response.data);
    }
    notifyListeners();
  }
}
