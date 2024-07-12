
 

import 'dart:developer';

import 'package:flutter/cupertino.dart';  
import 'package:grocery_app/models/transactions_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class TransactionsProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];  
  bool _isLoading = true;
  
  List<TransactionModel> get getTransactions {
    return _transactions;
  }  

  bool get isLoading {
    return _isLoading;
  }
  
  Future<void> fetchTransactions(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
   var response = await AuthenticationServices().getTransactions(context);

    log("33 transactions  ${response}");
    if (response.success && response.data != null) {
      log("44 transactions body ${response.data}");
      _transactions.addAll(response.data);
    }
    _isLoading = false;
    notifyListeners();
  }
}
