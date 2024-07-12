
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class CreditCardsProvider with ChangeNotifier {
  static List<CreditCardsModel> _creditCards = [];
  List<CreditCardsModel> get getCreditCards {
    return _creditCards;
  } 

  void deleteCreditCard(int userDeviceCardID) {
    int removeIndexItem = _creditCards.indexWhere((element) =>
        element.UserDeviceCardID == userDeviceCardID );
    _creditCards.removeAt(removeIndexItem);
    notifyListeners();
  } 
  
  Future<void> fetchCreditCards(BuildContext context) async {
   var response = await AuthenticationServices().getCreditCards(context);

    log("33 credit cards  ${response}");
    if (response.success && response.data != null) {
      log("44 credit cards body ${response.data}");
      _creditCards.addAll(response.data);
    }
    notifyListeners();
  }
}
