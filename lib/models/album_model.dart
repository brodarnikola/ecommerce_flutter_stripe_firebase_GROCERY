class Album {
  // final String name;
  // final String email;

  final int userId;
  final int id;
  final String title;

  Album(this.userId, this.id, this.title);

  Album.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int,
        id = json['id'] as int,
        title = json['title'] as String;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
      };

  static List<Album> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Album.fromJson(item as Map<String, dynamic>)).toList();
  }
}

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//     Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'userId': int userId,
//         'id': int id,
//         'title': String title,
//       } =>
//         Album(
//           userId: userId,
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }
// }
