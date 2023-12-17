import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/Sistem Manajemen/screens/deskirpsi_produk.dart';
import 'package:pustaring/Sistem Manajemen/widgets/left_drawer.dart';
import 'package:pustaring/peminjaman_buku/screens/detail_buku.dart';
import 'package:pustaring/peminjaman_buku/widgets/left_drawer_home.dart';

import '../../models/book.dart';

class PinjamBukuPage extends StatefulWidget {
  const PinjamBukuPage({Key? key}) : super(key: key);

  @override
  _PinjamBukuPageState createState() => _PinjamBukuPageState();
}

class _PinjamBukuPageState extends State<PinjamBukuPage> {
  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> bookList = [];

    for (var item in data) {
      bookList.add(Book.fromJson(item));
    }

    return bookList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BUKU YANG TERSEDIA"),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      drawer: const LeftDrawerHome(),
      backgroundColor: const Color(0xFFFFF0A3),
      body: FutureBuilder(
        future: fetchBooks(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada data buku.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBuku(
                          book: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: const Color(0xFFFFDD5E),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB15D08),
                            ),
                          ),
                          // Add more widgets based on your requirements
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
