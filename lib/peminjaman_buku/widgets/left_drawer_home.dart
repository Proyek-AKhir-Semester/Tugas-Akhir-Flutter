import 'package:flutter/material.dart';
import 'package:pustaring/Sistem Manajemen/screens/menu.dart';
import 'package:pustaring/Sistem Manajemen/screens/shoplist_form.dart';
import 'package:pustaring/peminjaman_buku/screens/pinjam_buku_page.dart';

class LeftDrawerHome extends StatelessWidget {
  const LeftDrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFFFF0A3), // Set the background color of the drawer
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFFAA5200), // Background color of the header
              ),

              child: Column(
                children: [
                  Text(
                    'Pustaring',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFF0A3),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "Pustaring: Your friendly book app",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFFFF0A3),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Halaman Utama'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinjamBukuPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Pinjam Buku'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinjamBukuPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Daftar Buku Pinjaman'),
              onTap: () {
                // Add your redirection logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LOGOUT'),
              onTap: () {
                // Add your redirection logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
