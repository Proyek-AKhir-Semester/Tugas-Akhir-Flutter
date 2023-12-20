import 'package:flutter/material.dart';
import 'package:pustaring/models/book.dart';
import 'package:pustaring/ulasan/screens/reviewListPage.dart';

class DetailBuku extends StatefulWidget {
  final Book book;

  const DetailBuku({Key? key, required this.book}) : super(key: key);

  @override
  State<DetailBuku> createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.fields.title),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color(0xFFFFF0A3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.book.fields.title}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB15D08),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Genre: ${widget.book.fields.genre}',
                style: TextStyle(
                  color: Color(0xFFB15D08),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Summary: ${widget.book.fields.summary}',
                style: TextStyle(
                  color: Color(0xFFB15D08),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Add your functionality here
                          print("temp");
                        },
                        child: const Text(
                          "Pinjam Buku",
                          style: TextStyle(color: Color.fromARGB(255, 243, 191, 58)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB15D08),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewListPage(bookId: widget.book.pk),
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Ulasan',
                          style: TextStyle(color: Color.fromARGB(255, 243, 191, 58)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB15D08),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
