import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
  final int bookId;

  const ReviewFormPage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 5; // Set a default value
  String _reviewText = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Ulasan Anda'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int>(
                value: _rating,
                items: [5, 4, 3, 2, 1].map((rating) {
                  return DropdownMenuItem<int>(
                    value: rating,
                    child: Text('$rating stars'),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    _rating = value ?? 5;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLines: 4,
                onChanged: (String value) {
                  setState(() {
                    _reviewText = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Ulasan tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Ulasan Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await request.postJson(
                      "http://localhost:8000/ulasan/create-review-flutter/${widget.bookId}/",
                      jsonEncode(<String, dynamic>{
                        'book_id': widget.bookId,
                        'rating': _rating,
                        'review_text': _reviewText,
                      }),
                    );

                    if (response['status'] == 'success') {
                      final reviewText = response['review_text'] ?? "Ulasan berhasil ditambahkan!";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(reviewText),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              Navigator.pop(context, true); // Memberikan sinyal ke halaman sebelumnya
                            },
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Terdapat kesalahan, silakan coba lagi."),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Kirim Ulasan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
