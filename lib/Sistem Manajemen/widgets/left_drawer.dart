import 'package:flutter/material.dart';
import 'package:pustaring/Sistem Manajemen/screens/menu.dart';
import 'package:pustaring/Sistem Manajemen/screens/shoplist_form.dart';

import '../screens/list_product.dart';
import '../screens/list_ruangan.dart';
import '../screens/tambah_ruangan.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFF0A3),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFAA5200),
            ),
            child: Column(
              children: [
                Text(
                  'Pustaring',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFF0A3),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Sistem Manajemen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFFFF0A3),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sistem_Manajemen(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Ruangan'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RuanganFormPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.meeting_room),
            title: const Text('Manage Ruangan'),
            onTap: () {
              // Route menu ke halaman produk
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RuangPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Manage Peminjaman'),
            onTap: () {
              // Route menu ke halaman produk
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}