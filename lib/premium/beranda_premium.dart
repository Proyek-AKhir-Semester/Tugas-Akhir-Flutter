import 'package:flutter/material.dart';
import 'package:pustaring/premium/pinjam_sewa_ruang.dart';

import 'book_model.dart';


class BerandaPremiumScreen extends StatelessWidget {
  const BerandaPremiumScreen({super.key});

  static List<BookModel> books = [
    BookModel(
        title: "The Forest House",
        genre: "Fantasy",
        summary:
            "In the early days of the conquest, when the Roman Legions are aggressively persecuting the Druids, the sanctuary of the Goddess on the isle of Mona is destroyed and its Druids are murdered and its priestesses are raped. The raped priestesses that conceive children kill all of the girl ......"),
    BookModel(
        title: "The Forest House",
        genre: "Fantasy",
        summary:
            "In the early days of the conquest, when the Roman Legions are aggressively persecuting the Druids, the sanctuary of the Goddess on the isle of Mona is destroyed and its Druids are murdered and its priestesses are raped. The raped priestesses that conceive children kill all of the girl ......"),
    BookModel(
        title: "The Forest House",
        genre: "Fantasy",
        summary:
            "In the early days of the conquest, when the Roman Legions are aggressively persecuting the Druids, the sanctuary of the Goddess on the isle of Mona is destroyed and its Druids are murdered and its priestesses are raped. The raped priestesses that conceive children kill all of the girl ......"),
  ];

  Widget bookCard(BuildContext context, BookModel book) {
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
          Text(book.title,
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
                  "Genre : ${book.genre}",
                  style: TextStyle(
                    color: Color(0XFFAA5200),
                  ),
                ),
                Text(
                  "Summary : ${book.summary}",
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
    return Scaffold(
      backgroundColor: Color(0XFFFFF0A3),
      appBar: AppBar(
        backgroundColor: Color(0XFFAA5200),
        title: Text(
          "Beranda Premium",
          style: TextStyle(color: Color(0XFFFFF0A3), fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              color: Color(0XFFFFF0A3),
              size: 32,
            )),
      ),
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
                    itemCount: 3,
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
