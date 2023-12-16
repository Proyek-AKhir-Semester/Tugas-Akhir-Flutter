import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/ulasan/models/product.dart';
import 'package:pustaring/ulasan/screens/reviewFormPage.dart';

class ReviewListPage extends StatefulWidget {
  final int bookId;
  const ReviewListPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  Future<List<Product>> fetchReviews({bool shouldRefresh = false}) async {
    List<Product> _reviews = []; // Deklarasi variabel _reviews
    var url = Uri.parse('http://localhost:8000/ulasan/get-reviews-json/${widget.bookId}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Product> reviews = [];
    for (var review in data) {
      if (review != null) {
        reviews.add(Product.fromJson(review));
      }
    }

    if (shouldRefresh) {
      setState(() {
        _reviews = reviews;
      });
    }

    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulasan Buku'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchReviews(),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada ulasan."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].userName}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Rating: ${snapshot.data![index].rating} stars"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].reviewText}"),
                            const SizedBox(height: 10),
                            Text(
                              "Date Added: ${snapshot.data![index].dateAdded}",
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Navigasi ke halaman form review dan tunggu hasilnya
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewFormPage(bookId: widget.bookId),
                ),
              );

              // Periksa apakah perlu memperbarui data
              if (result == true) {
                await fetchReviews(shouldRefresh: true);
              }
            },
            child: Text('Tambah Ulasan'),
          ),
        ],
      ),
    );
  }
}
