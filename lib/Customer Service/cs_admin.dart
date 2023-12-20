import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/Customer Service/models/product.dart';

class CSAdminPage extends StatefulWidget {
  const CSAdminPage({Key? key}) : super(key: key);

  @override
  _CSAdminPageState createState() => _CSAdminPageState();
}

class _CSAdminPageState extends State<CSAdminPage> {
  Future<List<Report>> fetchReport() async {
    var url = Uri.parse('https://pustaring-b05-tk.pbp.cs.ui.ac.id/customer_service/json/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Report> reports = [];
    for (var d in data) {
      if (d != null) {
        reports.add(Report.fromJson(d));
      }
    }
    return reports.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3)),
      backgroundColor: const Color(0xFFFFF0A3),
      body: FutureBuilder(
        future: fetchReport(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text("Tidak ada data produk.",
                    style: TextStyle(
                    color: Color(0xff59A5D8), fontSize: 20)),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  color: const Color(0xFFFFDD5E),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Laporan ${snapshot.data![index].pk}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Oleh ${snapshot.data![index].fields.username}", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.reportDate}", style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),
                      if (snapshot.data![index].fields.status != 'DONE')
                        ElevatedButton(
                          onPressed: () async {
                            String link = snapshot.data![index].fields.status == 'REQUESTED'
                              ? 'https://pustaring-b05-tk.pbp.cs.ui.ac.id/customer_service/confirm_report_flutter/'
                              : 'https://pustaring-b05-tk.pbp.cs.ui.ac.id/customer_service/finish_report_flutter/';
                            await request.postJson(link, jsonEncode(<String, int>{'id': snapshot.data![index].pk}));
                            String msg = snapshot.data![index].fields.status == 'REQUESTED' ? 'dikonfirmasi' : 'diselesaikan';
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Laporan ${snapshot.data![index].pk} berhasil $msg!', style: const TextStyle(fontSize: 16)),
                            ));
                            setState(() {
                              if (snapshot.data![index].fields.status =='REQUESTED') {
                                snapshot.data![index].fields.status = 'CONFIRMED';
                                snapshot.data![index].fields.message = 'Dikonfirmasi, menunggu pembayaan denda';
                              } else {
                                snapshot.data![index].fields.status = 'DONE';
                                snapshot.data![index].fields.message = 'Laporan selesai';
                              }
                            });
                          },
                          child: Text(snapshot.data![index].fields.status == 'REQUESTED' ? 'Konfirmasi' : 'Selesaikan'),
                        )
                      else
                        const Text("Selesai")
                    ],
                  ),
                )
              );
            }
          }
        }
      )
    );
  }
}