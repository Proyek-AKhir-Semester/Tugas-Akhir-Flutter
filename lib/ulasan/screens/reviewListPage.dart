import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/ulasan/models/product.dart';
import 'package:pustaring/ulasan/screens/reviewFormPage.dart';
import 'package:pustaring/ulasan/widgets/left_drawer.dart';

class ReviewListPage extends StatefulWidget {
  final int bookId;
  const ReviewListPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  Future<List<Product>> fetchReviews({bool shouldRefresh = false}) async {
    List<Product> _reviews = [];
    var url = Uri.parse('https://pustaring-b05-tk.pbp.cs.ui.ac.id/ulasan/get-reviews-json/${widget.bookId}/');
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
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 201, 117, 38), Color(0xFFFFF0A3)],
          ),
        ),
        child: Column(
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
                        // Reverse the list so that the latest review comes first
                        final reversedIndex = snapshot.data!.length - 1 - index;
                        final review = snapshot.data![reversedIndex];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          color: Color.fromARGB(255, 255, 211, 54),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${review.userName}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("Rating: ${review.rating} stars"),
                                const SizedBox(height: 10),
                                Text("${review.reviewText}"),
                                const SizedBox(height: 10),
                                Text(
                                  "Date Added: ${review.dateAdded}",
                                ),
                              ],
                            ),
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
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewFormPage(bookId: widget.bookId),
                  ),
                );

                if (result == true) {
                  await fetchReviews(shouldRefresh: true);
                }

              },

              child: Text('Tambah Ulasan',style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB15D08)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 243, 191, 58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}