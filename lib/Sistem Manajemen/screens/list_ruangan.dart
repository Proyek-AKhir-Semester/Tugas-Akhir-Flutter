import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/Sistem Manajemen/models/product.dart';
import 'package:pustaring/Sistem Manajemen/screens/deskirpsi_produk.dart';
import 'package:pustaring/Sistem Manajemen/widgets/left_drawer.dart';

import '../../models/ruangan.dart';

class RuangPage extends StatefulWidget {
  const RuangPage({Key? key}) : super(key: key);

  @override
  _RuangPageState createState() => _RuangPageState();
}

class _RuangPageState extends State<RuangPage> {
  Future<List<Ruangan>> fetchRuangan() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://pustaring-b05-tk.pbp.cs.ui.ac.id/sistem_manajemen/get-ruangan/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    // melakukan konversi data json menjadi object Product
    List<Ruangan> list_ruangan = [];

    for (var d in data) {
      list_ruangan.add(Ruangan.fromJson(d));
    }
    return list_ruangan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Ruangan"),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),


      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFFFFF0A3),
      body: FutureBuilder(
        future: fetchRuangan(),
        builder: (context, AsyncSnapshot<List<Ruangan>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada data produk.",
                  style: TextStyle(color: Color(0xFFAA5200), fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => GestureDetector(
                  child: Card(
                    elevation: 4, // Add elevation for a shadow effect
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: snapshot.data![index].fields.ketersediaan == "tersedia" ? const Color(0xFFFFDD5E) : const Color(0xFFFFF0A3), // Set background color
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Nomor Ruangan : ${snapshot.data![index].fields.nomor}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB15D08),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Status Tersedia : ${snapshot.data![index].fields.ketersediaan}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB15D08),
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                var url = Uri.parse(
                                    'https://pustaring-b05-tk.pbp.cs.ui.ac.id/sistem_manajemen/edit_ketersediaan/${snapshot.data![index].pk}');
                                http.get(url);
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFAA5200), // Button color
                              ),
                              child: const Text(
                                'Rubah Status',
                                style: TextStyle(
                                  color: Color(0xFFFFF0A3), // Text color
                                ),
                              ),),
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