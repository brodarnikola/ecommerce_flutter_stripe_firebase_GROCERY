import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VehiclesModel with ChangeNotifier {
  final int id, userId;
  final String title;
  // final Timestamp orderDate;

  VehiclesModel(
      this.id,
      this.userId,
      // this.orderDate
      this.title
      );

  VehiclesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userId = json['userId'] as int,
        title = json['title'] as String;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        // 'orderDate': orderDate,
      };
}

// class Album {
//   // final String name;
//   // final String email;

//   final int userId;
//   final int id;
//   final String title;

//   Album(this.userId, this.id, this.title);

//   Album.fromJson(Map<String, dynamic> json)
//       : userId = json['userId'] as int,
//         id = json['id'] as int,
//         title = json['title'] as String;

//   Map<String, dynamic> toJson() => {
//         'userId': userId,
//         'id': id,
//         'title': title,
//       };
// }
