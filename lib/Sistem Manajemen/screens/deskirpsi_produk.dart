

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../models/peminjaman.dart';
import '../models/product.dart';


class ItemDetailPage extends StatefulWidget {
  final Book item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  Future<List<Peminjaman>> fetchPeminjaman() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://pustaring-b05-tk.pbp.cs.ui.ac.id/sistem_manajemen/get-peminjaman/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    // melakukan konversi data json menjadi object Product
    List<Peminjaman> list_peminjaman = [];

    for (var d in data) {
      Peminjaman peminjaman = Peminjaman.fromJson(d);
      if(peminjaman.fields.buku == widget.item.fields.title) {
        list_peminjaman.add(Peminjaman.fromJson(d));
      }
    }
    return list_peminjaman;
  }

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      return "${date.day}-${date.month}-${date.year}";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("List Peminjaman : ${widget.item.fields.title}"),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color(0xFFFFF0A3),
        body: FutureBuilder(
          future: fetchPeminjaman(),
          builder: (context, AsyncSnapshot<List<Peminjaman>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Tidak ada Request Peminjaman Pada Buku ini",
                    style: TextStyle(color: Color(0xFFAA5200), fontSize: 50),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => GestureDetector(
                    child: Card(
                      elevation: 4, // Add elevation for a shadow effect
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: snapshot.data![index].fields.statusAcc ? const Color(0xFFFFDD5E) : const Color(0xFFFFF0A3), // Set background color
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tanggal Peminjaman : ${_formatDate(snapshot.data![index].fields.tanggalPeminjaman)}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB15D08),
                                    ),
                                  ),
                                  Text(
                                    "Tanggal Pengembalian :${_formatDate(snapshot.data![index].fields.tanggalPengembalian)}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB15D08),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      var url = Uri.parse(
                                          'https://pustaring-b05-tk.pbp.cs.ui.ac.id/sistem_manajemen/edit_peminjaman/${snapshot.data![index].pk}');
                                      http.get(url);
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFAA5200), // Button color
                                    ),
                                    child: Text(
                                      'Terima Peminjaman',
                                      style: TextStyle(
                                        color: const Color(0xFFFFF0A3), // Text color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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