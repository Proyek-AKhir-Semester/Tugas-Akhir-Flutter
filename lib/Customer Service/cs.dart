import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/Customer Service/models/product.dart';
import 'package:pustaring/Customer Service/laporan.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CSPage extends StatefulWidget {
  const CSPage({Key? key}) : super(key: key);

  @override
  _CSPageState createState() => _CSPageState();
}

class _CSPageState extends State<CSPage> {
  Future<List<Report>> fetchReport() async {
    var url = Uri.parse('https://pustaring-b05-tk.pbp.cs.ui.ac.id/customer_service/json_by_user/');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});
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
    TextEditingController textFieldController = TextEditingController();
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3)),
      backgroundColor: const Color(0xFFFFF0A3),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const ReportPage()
                  )
                );
              },
              child: const Text('Buat Laporan')
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Buat Aduan'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: textFieldController,
                              decoration: const InputDecoration(
                                labelText: 'Masukkan aduan Anda!',
                                hintText: 'Ketik di sini...',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Kirim'),
                          onPressed: () async {
                            String complaint = textFieldController.text;
                            if (!(complaint.isEmpty || complaint.trim().isEmpty)) {
                              final response = await request.postJson(
                                'https://pustaring-b05-tk.pbp.cs.ui.ac.id/customer_service/add_complaint_flutter/',
                                jsonEncode(<String, String>{'description': complaint}));
                            }
                            Navigator.pop(context);
                          }
                        )
                      ],
                    );
                  }
                );
              },
              child: const Text('Buat Aduan'),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: fetchReport(),
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
                          Text(
                            "Laporan ${snapshot.data![index].pk}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.reportDate}", style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.message}", style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    )
                  );
                }
              }
            }
          )
        ),
      ]),
    );
  }
}