import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  void clearLocalOrders() {
    _orders.clear();
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user?.uid;

    // User? user = authInstance.currentUser;

    log("order.. uid data: $uid}");
    if (uid != null) {
      await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: uid)
          .orderBy('orderDate', descending: false)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _orders = [];
        // _orders.clear();
        for (var element in ordersSnapshot.docs) {
          _orders.insert(
            0,
            OrderModel(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              userName: element.get('userName'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      });

      notifyListeners();
    }
  }
}
