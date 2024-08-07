import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static String getDateFromDateTimeString(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime todayDate = DateTime.now();
    DateTime tomorrowDate = DateTime.now().add(Duration(days: 1));

    String today = DateFormat('d.M.y').format(todayDate);
    String tomorrow = DateFormat('d.M.y').format(tomorrowDate);
    String newDate = DateFormat('d.M.y').format(date);

    if (today == newDate) return 'Today';
    if (tomorrow == newDate) return 'Tomorrow';

    return newDate;
  }

  static String getTimeFromDateTimeString(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat.jm().format(date); // jm format for Hour:Minute AM/PM
  }

  static String convertToISO(String dateString) {
    // Split the input string into date and time components
    List<String> dateTimeParts = dateString.split(' ');

    // Split the date component into day, month, and year
    List<String> dateParts =
        dateTimeParts[0].split('.').map((str) => str.padLeft(2, '0')).toList();

    // Combine date and time parts into a single string
    String combinedDateTimeString =
        '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}T${dateTimeParts[1]}:00';

    return combinedDateTimeString;
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return 
          // Dialog(
          //     insetPadding:
          //         EdgeInsets.all(10), // You can adjust this value as needed
          //     child:
               AlertDialog(
                title: Row(children: [
                  Image.asset(
                    'assets/images/warning-sign.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(child: Text(title)),
                ]),
                content: Text(subtitle),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: TextWidget(
                      color: Colors.cyan,
                      text: 'Cancel',
                      textSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: TextWidget(
                      color: Colors.red,
                      text: 'OK',
                      textSize: 18,
                    ),
                  ),
                ],
              // )
              );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('An Error occured'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

  static Future<void> addToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
