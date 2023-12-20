import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/peminjaman_buku/models/PinjamBuku.dart';
import '../../Auth/login.dart';
import '../widgets/left_drawer_home.dart';
import '';

class ListBukuPinjaman extends StatefulWidget {
  const ListBukuPinjaman({Key? key}) : super(key: key);



  @override
  _ListBukuPinjamanState createState() => _ListBukuPinjamanState();
}

class _ListBukuPinjamanState extends State<ListBukuPinjaman> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Peminjaman>> fetchData() async {
    String username = LoginPBPage.uname;

    // Ganti URL dengan URL endpoint yang sesuai di backend Django
    var url = Uri.parse('https://pustaring-b05-tk.pbp.cs.ui.ac.id/peminjaman_buku/list_buku_flutter/$username/');

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Peminjaman> pinjamanList = [];

    for (var item in data) {
      pinjamanList.add(Peminjaman.fromJson(item));
    }
    return pinjamanList;

  }

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      return "${date.day}-${date.month}-${date.year}";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku Pinjaman'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      drawer: const LeftDrawerHome(),
      backgroundColor: const Color(0xFFFFF0A3),
      body: FutureBuilder(
        future: fetchData(),
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
                  // onTap: () {
                  //   var url = Uri.parse(
                  //       'http://127.0.0.1:8000/sistem_manajemen/edit_peminjaman/${snapshot.data![index].pk}');
                  //   var response = http.get(url);
                  //   setState(() {});
                  // },
                  child: Card(
                    elevation: 4, // Add elevation for a shadow effect
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: snapshot.data![index].fields.statusAcc ? const Color(0xFFFFDD5E) : const Color(0xFFFFF0A3), // Set background color
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Judul : ${snapshot.data![index].fields.buku}",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB15D08),
                            ),
                          ),
                          Text(
                            "Tanggal Peminjaman: ${_formatDate(snapshot.data![index].fields.tanggalPeminjaman)}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFB15D08),
                            ),
                          ),
                          Text(
                            "Tanggal Pengembalian: ${_formatDate(snapshot.data![index].fields.tanggalPengembalian)}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFB15D08),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFB15D08),
                            ),
                            onPressed: () {
                              if (snapshot.data![index].fields.statusAcc) {
                                var url = Uri.parse(
                                    'https://pustaring-b05-tk.pbp.cs.ui.ac.id/peminjaman_buku/kembalikan_buku/${snapshot.data![index].fields.buku}/');
                                var response = http.get(url);
                                setState(() {});

                                // Show success pop-up
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Buku Berhasil Dikembalikan'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Show failure pop-up
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Buku Belum Diacc'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              'OK'
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              'Kembalikan',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
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