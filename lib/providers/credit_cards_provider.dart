import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/credit_cards_model.dart'; 

class CreditCardsProvider with ChangeNotifier {
  static List<CreditCardsModel> _vehicles = [];
  List<CreditCardsModel> get getVehicles {
    return _vehicles;
  }

  void clearVehicles() {
    _vehicles.clear();
    notifyListeners();
  }

  void deleteVehicle(int index) {
    _vehicles.removeAt(index);
    notifyListeners();
  }

  void addVehicle(CreditCardsModel data) {
    _vehicles.add(data);
    notifyListeners();
  }

  void updateVehicle(CreditCardsModel data) {
    // int index = _vehicles.indexWhere((element) =>
    //     element.UserDeviceVehicleID == data.UserDeviceVehicleID );
    // _vehicles[index] = data;
    notifyListeners();
  }

  Future<void> fetchVehicles() async {
    // var response = await AuthenticationServices().getVehicles();

    // log("vehicles  ${response}");
    // if (response.success && response.data != null) {
    //   log("vehicles body ${response.data}");
    //   _vehicles.addAll(response.data);
    // }
    notifyListeners();
  }
}
