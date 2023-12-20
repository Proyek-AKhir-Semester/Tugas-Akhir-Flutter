import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:pustaring/peminjaman_buku/screens/detail_buku.dart';
import 'package:pustaring/peminjaman_buku/widgets/left_drawer_home.dart';
import '../../Auth/login.dart';
import '../../models/book.dart';
import 'package:pustaring/peminjaman_buku/screens/list_buku_pinjaman.dart';

class PinjamBukuPage extends StatefulWidget {
  const PinjamBukuPage({Key? key}) : super(key: key);

  @override
  _PinjamBukuPageState createState() => _PinjamBukuPageState();
}

class _PinjamBukuPageState extends State<PinjamBukuPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedGenre = 'All'; // Default selected genre

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

    // Apply genre filter
    if (selectedGenre != 'All') {
      bookList = bookList.where((book) => book.fields.genre == selectedGenre).toList();
    }

    return bookList;
  }

  Future<void> createPinjamBuku(String username, String buku, String tanggalPeminjaman, String tanggalPengembalian) async {
    final url = 'https://pustaring-b05-tk.pbp.cs.ui.ac.id/create_pinjam_buku/';


    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'buku': buku,
        'tanggal_peminjaman': tanggalPeminjaman,
        'tanggal_pengembalian': tanggalPengembalian,
      }),
    );

    if (response.statusCode == 200) {
      print('PinjamBuku created successfully');
    } else {
      print('Failed to create PinjamBuku');
    }
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      appBar: AppBar(
        title: const Text("BUKU YANG TERSEDIA"),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      drawer: const LeftDrawerHome(),

      backgroundColor: const Color(0xFFFFF0A3),
      body: Column(
        children: [
          // Filter dropdown
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Filter:     ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB15D08),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB15D08),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedGenre,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGenre = newValue!;
                      });
                    },
                    items: <String>['All', 'fantasy', 'science', 'crime', 'history',
                      'horror', 'thriller', 'psychology', 'romance', 'sports', 'travel'] // Add your genres here
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),

                      );
                    }).toList(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),

                    dropdownColor: Color(0xFFB15D08), // Change to your desired color
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFFFFDD5E),

                    ),
                    hint: Text(
                      selectedGenre,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Book list
          Expanded(
            child: FutureBuilder(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB15D08),
                                  ),
                                ),
                                Text(
                                  "Genre : ${snapshot.data![index].fields.genre}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFFB15D08),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFB15D08),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailBuku(
                                              book: snapshot.data![index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Lihat detail buku',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFB15D08),
                                      ),
                                      onPressed: () async {
                                        // Kirim ke Django dan tunggu respons
                                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                        final response = await request.postJson(
                                            "https://pustaring-b05-tk.pbp.cs.ui.ac.id/peminjaman_buku/create_pinjam_buku/",
                                            jsonEncode(<String, String>{
                                              'username' : LoginPBPage.uname,
                                              'buku': snapshot.data![index].fields.title,
                                            }));
                                        if (response['status'] == 'success') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("Item baru berhasil disimpan!"),
                                          ));
                                        } else if (response['status'] == 'duplicate'){
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("Buku ini sudah anda pinjam"),
                                          ));
                                        }
                                        else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                            Text("Terdapat kesalahan, silakan coba lagi."),
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        'Pinjam Buku',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}