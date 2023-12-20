import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/peminjaman_buku/models/PinjamBuku.dart';
import '../../Auth/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/Customer Service/cs.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Map<int, int> statusMap = {};
  String username = LoginPBPage.uname;
  Future<List<Peminjaman>> fetchData() async {
    var url = Uri.parse('http://127.0.0.1:8000/peminjaman_buku/list_buku_flutter/$username/');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Peminjaman> pinjamanList = [];
    for (var item in data) {
      Peminjaman p = Peminjaman.fromJson(item);
      if (p.fields.statusAcc) {
        pinjamanList.add(Peminjaman.fromJson(item));
        if (!statusMap.containsKey(p.pk)) {
          statusMap[p.pk] = 0;
        }
      }
    }
    return pinjamanList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color.fromARGB(255, 102, 99, 82),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const CSPage()
                  )
                );
              },
              child: const Text("Kembali")
            ),
            ElevatedButton(
              onPressed: () async {
                List<int> brokens = [], losts = [];
                statusMap.forEach((key, value) {
                  if (value == 1) {
                    brokens.add(key);
                  } else if (value == 2) {
                    losts.add(key);
                  }
                  if (brokens.length + losts.length > 0) {
                    final response = request.postJson("http://127.0.0.1:8000/customer_service/add_report_flutter/",
                      jsonEncode(<String, String>{
                        'username': username,
                        'losts': jsonEncode(losts),
                        'brokens': jsonEncode(brokens)
                      })
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Laporan telah dibuat!"),
                    ));
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const CSPage()
                      )
                    );
                  }
                });
              },
              child: const Text('Buat Laporan')
            )
          ]
        ),
        Expanded(child: FutureBuilder(
          future: fetchData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text("Tidak ada data produk.", style: TextStyle(color: Color(0xff59A5D8), fontSize: 20)),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    color: const Color(0xFFFFDD5E),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${snapshot.data![index].fields.buku}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        const SizedBox(height: 9),
                        Text("Dipinjam pada ${snapshot.data![index].fields.tanggalPeminjaman}"),
                        const SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          hint: const Text('Opsi'),
                          value: 'Status',
                          onChanged: (newValue) {
                            setState(() {
                              String selectedValue = newValue!;
                              if (selectedValue == 'Rusak') {
                                statusMap[snapshot.data![index].pk] = 1;
                              } else if (selectedValue == 'Hilang') {
                                statusMap[snapshot.data![index].pk] = 2;
                              }
                            });
                          },
                          items: <String>['Status','Rusak', 'Hilang'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        )
                      ]
                    )
                  )
                );
              }
            }
          }
        ))
      ])
    );
  }
}