import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart'; 

import 'dart:developer' as developer;

// @JsonSerializable()
// class LatLng {

 
//   final double lat;
//   final double lng;

//   LatLng(
//     this.lat,
//     this.lng,
//   );

//   //  LatLng({
//   //   required this.lat,
//   //   required this.lng,
//   // });

//   // Album(this.userId, this.id, this.title);

//   // Album.fromJson(Map<String, dynamic> json)
//   //     : userId = json['userId'] as int,
//   //       id = json['id'] as int,
//   //       title = json['title'] as String;

//   // Map<String, dynamic> toJson() => {
//   //       'userId': userId,
//   //       'id': id,
//   //       'title': title,
//   //     };

//   LatLng.fromJson(Map<String, dynamic> json)   : lat = json['lat'] as double,
//         lng = json['lng'] as double;

//   Map<String, dynamic> toJson() => {
//         'lat': lat,
//         'lng': lng
//       };
// }

// @JsonSerializable()
// class Region {
//   Region({
//     required this.coords, 
//     required this.name,
//     required this.zoom,
//   });

//   Region.fromJson(Map<String, dynamic> json) :
//    coords = json['coords'] as LatLng,
//    name = json['name'] as String,
//         zoom = json['zoom'] as double;

//   Map<String, dynamic> toJson() => {
//         'coords': coords,
//         'name': name,
//         'zoom': zoom
//       }; 

//   final LatLng coords; 
//   final String name;
//   final double zoom;
// }

// @JsonSerializable()
// class Office {
//   Office({
//     required this.address, 
//     required this.name,
//     required this.lat,
//     required this.lng,
//   });

//   Office.fromJson(Map<String, dynamic> json) : 
//    address = json['address'] as String,
//    lat = json['lat'] as double,
//    lng = json['lng'] as double,
//         name = json['name'] as String;

//   Map<String, dynamic> toJson() => { 
//         'address': address,
//         'lat': lat,
//         'lng': lng,
//         'name': name
//       }; 
 
//   final String address; 
//   final String name;
//   final double lat;
//   final double lng;
// }

// // @JsonSerializable()
// class Locations {
//   Locations({
//     required this.offices,
//     // required this.regions,
//   });

//   // factory Locations.fromJson(Map<String, dynamic> json) =>
//   //     _$LocationsFromJson(json);
//   // Map<String, dynamic> toJson() => _$LocationsToJson(this);

//   Locations.fromJson(Map<String, dynamic> json) : 
//    offices = json['offices'] as List<Office>;
//         // regions = json['regions'] as List<Region>;

//   Map<String, dynamic> toJson() => { 
//         'offices': offices,
//         // 'regions': regions
//       }; 

// static List<Locations> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => Locations.fromJson(item as Map<String, dynamic>)).toList();
//   }

//   final List<Office> offices;


//   // final List<Region> regions;
// }

// Future<Locations?> getGoogleOffices() async {
//   const googleLocationsURL = 'https://about.google/static/data/locations.json';

//   // Retrieve the locations of Google offices
//   try {
//     final response = await http.get(Uri.parse(googleLocationsURL));
//     developer.log(" response is Google offices: ${response.statusCode}"); 
//     developer.log(" BODY RESPONSE is Google offices: ${response.body}"); 
//     if (response.statusCode == 200) {

//       var albumList = Locations.fromJsonList(response.body as List<dynamic>);

//       albumList.first.offices.forEach((album) {
//         print(
//             'userId: ${album.address} ');
//       });

//       return Locations.fromJsonList(
//           json.decode(response.body) as Map<String, dynamic>);
//     }
//   } catch (e) {

//     developer.log(" Exception is Google offices: ${e.toString()}"); 
//     print(" Exception is  Google offices: ${e.toString()}");
//     if (kDebugMode) {
//       print(e);
//     }
//   }

//   return null;

//   // Fallback for when the above HTTP request fails.
//   // return Locations.fromJson(
//   //   json.decode(
//   //     await rootBundle.loadString('assets/locations.json'),
//   //   ) as Map<String, dynamic>,
//   // );
// }