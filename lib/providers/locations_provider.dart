import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/locations_model.dart';
import 'package:grocery_app/services/authentication_services.dart'; 

class LocationsProvider with ChangeNotifier {

  static List<LocationsModel> _locations = [];
  List<LocationsModel> get getLocations {
    return _locations;
  }

  static List<ParkingTypesModel> _parkingTypes = [];
  List<ParkingTypesModel> get getParkingTypes {
    return _parkingTypes;
  }

  Future<void> fetchLocationsAndParkingTypes(BuildContext context) async {
    var response = await AuthenticationServices().getLocationsAndParkingTypes(context);

    log("33 locations and parkings types  ${response}");
    if (response.success && response.data.locations != null) {
      log("44 locations  body ${response.data}");
      _locations.addAll(response.data.locations);
    }
     if (response.success && response.data.parkingType != null) {
      log("44 parkings types body ${response.data}");
      _parkingTypes.addAll(response.data.parkingType);
    }
    notifyListeners();
  }
}
