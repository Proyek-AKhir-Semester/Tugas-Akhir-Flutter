// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    String userName;
    int rating;
    String reviewText;
    DateTime dateAdded;

    Welcome({
        required this.userName,
        required this.rating,
        required this.reviewText,
        required this.dateAdded,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        userName: json["user_name"],
        rating: json["rating"],
        reviewText: json["review_text"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "rating": rating,
        "review_text": reviewText,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    };
}
