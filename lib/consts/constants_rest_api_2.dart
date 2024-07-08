
 

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {


//    // example 1  ------------- START“

//   Future<ResponseWrapper<T>> get<T>(String url, {Map<String, String>? headers}) async {
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return ResponseWrapper.success(data);
//       } else {
//         return ResponseWrapper.error("Unexpected status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       return ResponseWrapper.error(e.toString());
//     }
//   }

//   // example 1 ------------- END



//   // example 2  ------------- START“

//   static const API = 'http://api.notes.programmingaddict.com';
//   static const headers = {'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471'};

//   Future<APIResponse<List<NoteForListing>>> getNotesList() {
//     return http.get(Uri.parse('$API/notes'), headers: headers).then((data) {
//       if (data.statusCode == 200) {
//         final jsonData = json.decode(data.body);
//         final notes = <NoteForListing>[];
//         for (var item in jsonData) {
//           final note = NoteForListing(
//             noteID: item['noteID'], 
//             createDateTime: DateTime.parse(item['createDateTime']),
//             latestEditDateTime: item['latestEditDateTime'] != null
//               ? DateTime.parse(item['latestEditDateTime']!)
//               : null,
//           );
//           notes.add(note);
//         }
//         return APIResponse<List<NoteForListing>>(notes, '', false);
//       }
//       return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured');
//     })
//     .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured'));
//   }


//   // example 2 ------------- END


// }



//   // example 1 ------------- START

// class ResponseWrapper<T> {
//   final T? data;
//   final String? errorMessage;

//   ResponseWrapper.success(this.data) : errorMessage = null;
//   ResponseWrapper.error(this.errorMessage) : data = null;

//   bool get isSuccess => errorMessage == null;
// }



//   // example 1 ------------- END




//   // example 2 ------------- START

// class APIResponse<T> {
//   T data;
//   bool error;
//   String errorMessage;

//   APIResponse(this.data, this.errorMessage, this.error);
// }


// class NoteForListing {
//   String noteID;
//   DateTime createDateTime;
//   DateTime? latestEditDateTime;
  
//   NoteForListing({required this.noteID, required this.createDateTime, required this.latestEditDateTime});


//   // NoteForListing.fromJson(Map<String, dynamic> json)
//   //     : noteID = json['noteID'] as String,
//   //       createDateTime = json['createDateTime'] as DateTime,
//   //       latestEditDateTime = json['latestEditDateTime'] as DateTime;

//   // Map<String, dynamic> toJson() => {
//   //       'noteID': noteID,
//   //       'createDateTime': createDateTime,
//   //       'latestEditDateTime': latestEditDateTime,
//   //     };

// }

//   // example 2 ------------- END
  

