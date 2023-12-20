import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/premium/pinjam_sewa_ruang.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';
import '../peminjaman_buku/widgets/left_drawer_home.dart';

class BerandaPremiumScreen extends StatefulWidget {
  const BerandaPremiumScreen({Key? key}) : super(key: key);

  @override
  State<BerandaPremiumScreen> createState() => _BerandaPremiumScreenState();
}

class _BerandaPremiumScreenState extends State<BerandaPremiumScreen> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks().then((bookList) {
      setState(() {
        books = bookList;
      });
    });
  }

  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse('https://pustaring-b05-tk.pbp.cs.ui.ac.id/api/books/');
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

  Widget bookCard(BuildContext context, Book book) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0XFFFFD336),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text(book.fields.title,
              style: TextStyle(
                color: Color(0XFFAA5200),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genre : ${book.fields.genre}",
                  style: TextStyle(
                    color: Color(0XFFAA5200),
                  ),
                ),
                Text(
                  "Summary : ${book.fields.summary}",
                  style: TextStyle(
                    color: Color(0XFFAA5200),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PinjamSewaRuangScreen()));
                  },
                  child: Container(
                    height: 21,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color(0XFFFFC736),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                          "Pinjam",
                          style: TextStyle(color: Color(0XFF4D1212)),
                        )),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    height: 21,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color(0XFFFFC736),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                          "Lihat Detail",
                          style: TextStyle(color: Color(0XFF4D1212)),
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Color(0XFFFFF0A3),
      appBar: AppBar(
        backgroundColor: Color(0XFFAA5200),
        title: Text(
          "Beranda Premium",
          style: TextStyle(color: Color(0XFFFFF0A3), fontSize: 20),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Color(0XFFFFF0A3),
              size: 32,
            ),
          ),
        ),
      ),
      drawer: const LeftDrawerHome(),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 53,
        color: Color(0XFFAA5200),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFFC736),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                height: 34,
                width: 228,
                child: Center(child: Text("DAFTAR BUKU PREMIUM")),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: 328,
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return bookCard(context, books[index]);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}