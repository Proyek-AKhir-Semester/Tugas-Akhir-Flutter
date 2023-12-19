// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String userName;
    int rating;
    String reviewText;
    DateTime dateAdded;

    Product({
        required this.userName,
        required this.rating,
        required this.reviewText,
        required this.dateAdded,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
