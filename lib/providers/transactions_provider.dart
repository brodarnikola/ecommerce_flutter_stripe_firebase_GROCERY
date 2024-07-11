
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';  
import 'package:grocery_app/models/transactions_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class TransactionsProvider with ChangeNotifier {
  static List<TransactionModel> _transactions = [];
  List<TransactionModel> get getTransactions {
    return _transactions;
  }  
  
  Future<void> fetchTransactions(BuildContext context) async {
   var response = await AuthenticationServices().getTransactions(context);

    log("transactions  ${response}");
    if (response.success && response.data != null) {
      log("transactions body ${response.data}");
      _transactions.addAll(response.data);
    }
    notifyListeners();
  }
}
