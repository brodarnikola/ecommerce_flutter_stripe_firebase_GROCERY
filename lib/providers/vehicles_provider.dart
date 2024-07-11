import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/vehicles_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class VehiclesProvider with ChangeNotifier {
  static List<VehiclesModel> _vehicles = [];
  List<VehiclesModel> get getVehicles {
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

  void addVehicle(VehiclesModel data) {
    _vehicles.add(data);
    notifyListeners();
  }

  void updateVehicle(VehiclesModel data) {
    int index = _vehicles.indexWhere((element) =>
        element.UserDeviceVehicleID == data.UserDeviceVehicleID );
    _vehicles[index] = data;
    notifyListeners();
  }

  Future<void> fetchVehicles(BuildContext context) async {
    var response = await AuthenticationServices().getVehicles(context);

    log("vehicles  ${response}");
    if (response.success && response.data != null) {
      log("vehicles body ${response.data}");
      _vehicles.addAll(response.data);
    }
    notifyListeners();
  }
}
