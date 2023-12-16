import 'package:flutter/material.dart';
import 'package:pustaring/ulasan/screens/reviewListPage.dart';
import '../../models/book.dart'; // Import your Book model here

class BookDetailPage extends StatelessWidget {
  final Book book; // Assuming you pass the book object to this widget

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Buku'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Judul: ${book.fields.title}', style: TextStyle(fontSize: 20)),
                Text('Genre: ${book.fields.genre}', style: TextStyle(fontSize: 18)),
                Text('Ketersediaan: ${book.fields.ketersediaan == 'Tersedia' ? 'Tersedia' : 'Tidak tersedia'}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Ringkasan: ${book.fields.summary}'),
                // Add your buttons here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk navigasi kembali
                        Navigator.pop(context); // Misalnya, kembali ke halaman sebelumnya
                      },
                      child: Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk melihat ulasan
                        // Navigasi ke halaman detail ulasan buku dengan mempassing bukuId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewListPage(bookId: book.pk),
                          ),
                        );
                      },
                      child: Text('Lihat Ulasan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
