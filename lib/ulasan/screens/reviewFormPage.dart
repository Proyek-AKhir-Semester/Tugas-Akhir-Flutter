import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/ulasan/screens/login.dart';
import 'package:pustaring/ulasan/widgets/left_drawer.dart';

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

  // Function to clear the form
  void _clearForm() {
    setState(() {
      _rating = 5;
      _reviewText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Ulasan Anda'),
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
        child: Center(
          child: Column(
            children: [
              Card(
                color: Color.fromARGB(255, 255, 211, 54),
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<int>(
                          value: _rating,
                          items: [5, 4, 3, 2, 1].map((rating) {
                            return DropdownMenuItem<int>(
                              value: rating,
                              child: Text('$rating stars', style: TextStyle(fontSize: 16)),
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
                            filled: true,
                            fillColor: Color.fromARGB(255, 170, 82, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back when "Kembali" button is pressed
                      Navigator.pop(context,true);
                    },
                    child: const Text(
                      "Kembali",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB15D08)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 243, 191, 58),
                    )
                  ),
                  ElevatedButton(
                  onPressed: () async {
                    final request = context.read<CookieRequest>();
                    if (request.loggedIn) {
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
                            content: Text(reviewText, style: TextStyle(fontSize: 16)),
                          ),
                        );
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Terdapat kesalahan, silakan coba lagi.", style: TextStyle(fontSize: 16)),
                          ),
                        );
                      }
                    }
                  }else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Gagal Menambahkan Ulasan', style: TextStyle(color: Color.fromARGB(255, 119, 63, 6))),
                        content: Text('Silakan login untuk menambahkan ulasan.',style: TextStyle(color: Color.fromARGB(255, 119, 63, 6))),
                        backgroundColor: Color.fromARGB(255, 243, 191, 58),
                        actions: [
                          TextButton(
                            child: Text('Login', style: TextStyle(color: Color.fromARGB(255, 138, 112, 47)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginApp()),
                              );
                            },
                          ),
                          TextButton(
                            child: Text('Batal',style: TextStyle(color: Color.fromARGB(255, 138, 112, 47)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                    child: const Text(
                      "Kirim Ulasan",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB15D08)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 243, 191, 58),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
