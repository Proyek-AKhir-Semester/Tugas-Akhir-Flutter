import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pustaring/ulasan/models/product.dart'; // Import your Review model here
import 'package:http/http.dart' as http;

class ReviewBukuPage extends StatelessWidget {
  final int? bukuId;

  ReviewBukuPage({Key? key, required this.bukuId}) : super(key: key);

  Future<List<Product>> fetchReviews() async {
    // TODO: Fetch reviews based on bukuId from your API
    // Adjust the URL and endpoint accordingly
    var url = Uri.parse('http://localhost:8000/ulasan/get-reviews-json/$bukuId');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // Decode response into a list of Review objects
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Product> reviews = [];

    for (var d in data) {
      reviews.add(Product.fromJson(d));
    }

    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    if (bukuId == null) {
      // Handle the case where bukuId is null
      return Scaffold(
        appBar: AppBar(
          title: Text('Ulasan Buku'),
        ),
        body: Center(
          child: Text('No bukuId provided'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan Buku'),
      ),
      body: FutureBuilder(
        future: fetchReviews(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].userName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rating: ${snapshot.data![index].rating}'),
                      Text(snapshot.data![index].reviewText),
                      Text('Date: ${snapshot.data![index].dateAdded}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
