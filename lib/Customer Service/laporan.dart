import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pustaring/Customer Service/models/product.dart';
import 'package:pustaring/peminjaman_buku/models/PinjamBuku.dart';
import 'package:pustaring/peminjaman_buku/screens/list_buku_pinjaman.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Future<List<Report>> fetchReport() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://<URL_APP_KAMU>/json/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Report> reports = [];
    for (var d in data) {
      if (d != null) {
        reports.add(Report.fromJson(d));
      }
    }
    return reports;
  }

  @override
  Widget build(BuildContext context) {
    ListBukuPinjaman lsb = ListBukuPinjaman();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku Pinjaman'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color.fromARGB(255, 102, 99, 82),
      
    );
  }
}
