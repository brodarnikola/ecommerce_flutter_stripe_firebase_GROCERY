import 'dart:convert';
import 'dart:developer';
  
import 'package:flutter/cupertino.dart'; 
import 'package:grocery_app/models/vehicles_model.dart';
import 'package:grocery_app/services/authentication_services.dart';

import 'package:http/http.dart' as http;

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
    int index = _vehicles.indexWhere((element) => element.UserDeviceVehicleID == data.UserDeviceVehicleID && element.UserDeviceID == data.UserDeviceID);
    _vehicles[index] = data;
    notifyListeners();
  }

  // Future<Album> fetchAlbum() async {
  //   final response = await http
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.

  //     log("album  ${response}");
  //     log("album body ${response.body}");
  //     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<void> fetchVehicles() async {

    var response = await AuthenticationServices().getVehicles();

    log("vehicles  ${response}"); 
    if( response.success && response.data != null) {
      log("vehicles body ${response.data}");
      _vehicles.addAll(response.data);
    }
    // else {
    //   // throw Exception('Failed to load vehicles');
    // }

        //   for (var element in ordersSnapshot.docs) {
        //   _vehicles.insert(
        //     0,
        //     VehiclesModel(
        //       orderId: element.get('orderId'),
        //       userId: element.get('userId'),
        //       productId: element.get('productId'),
        //       userName: element.get('userName'),
        //       price: element.get('price').toString(),
        //       imageUrl: element.get('imageUrl'),
        //       quantity: element.get('quantity').toString(),
        //       orderDate: element.get('orderDate'),
        //     ),
        //   );
        // }

    // final response = await http
    //     .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.

    //   log("vehicles  ${response}");
    //   log("vehicles body ${response.body}");
    //   VehiclesModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load vehicles');
    // }

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // var uid = user?.uid;

    // // User? user = authInstance.currentUser;

    // log("order.. uid data: $uid}");
    // if (uid != null) {
    //   await FirebaseFirestore.instance
    //       .collection('orders')
    //       .where('userId', isEqualTo: uid)
    //       .orderBy('orderDate', descending: false)
    //       .get()
    //       .then((QuerySnapshot ordersSnapshot) {
    //     _vehicles = [];
    //     // _vehicles.clear();
    //     for (var element in ordersSnapshot.docs) {
    //       _vehicles.insert(
    //         0,
    //         VehiclesModel(
    //           orderId: element.get('orderId'),
    //           userId: element.get('userId'),
    //           productId: element.get('productId'),
    //           userName: element.get('userName'),
    //           price: element.get('price').toString(),
    //           imageUrl: element.get('imageUrl'),
    //           quantity: element.get('quantity').toString(),
    //           orderDate: element.get('orderDate'),
    //         ),
    //       );
    //     }
    //   });

      notifyListeners();
    // }
  }
}
