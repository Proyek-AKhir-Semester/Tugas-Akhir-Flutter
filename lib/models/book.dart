// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    model: modelValues.map[json["model"]]!,
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String title;
  String genre;
  String summary;
  String ketersediaan;
  String vip;

  Fields({
    required this.title,
    required this.genre,
    required this.summary,
    required this.ketersediaan,
    required this.vip,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    title: json["title"],
    genre: json["genre"],
    summary: json["summary"],
    ketersediaan: json["ketersediaan"],
    vip: json["vip"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "genre": genre,
    "summary": summary,
    "ketersediaan": ketersediaan,
    "vip": vip,
  };
}

enum Model {
  BOOK_BOOK
}

final modelValues = EnumValues({
  "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
