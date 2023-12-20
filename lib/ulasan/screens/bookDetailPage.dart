import 'package:flutter/material.dart';
import 'package:pustaring/ulasan/screens/reviewListPage.dart';

import '../../models/book.dart';


class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Buku'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 201, 117, 38), Color(0xFFFFF0A3)],
          ),
        ),
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 255, 211, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                width: screenWidth, // Set the width of the card to screen width
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${book.fields.title}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('Genre: ${book.fields.genre}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Text('Summary: ${book.fields.summary}'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk navigasi kembali
                    Navigator.pop(context);
                  },
                  child: Text('Back',style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB15D08)),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 243, 191, 58),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk melihat ulasan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewListPage(bookId: book.pk),
                      ),
                    );
                  },
                  child: Text('Lihat Ulasan',style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB15D08)),),
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
