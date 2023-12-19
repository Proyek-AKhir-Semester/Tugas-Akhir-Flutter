import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/Sistem Manajemen/screens/menu.dart';
import 'package:pustaring/Sistem Manajemen/screens/shoplist_form.dart';
import 'package:pustaring/peminjaman_buku/screens/list_buku_pinjaman.dart';
import 'package:pustaring/peminjaman_buku/screens/pinjam_buku_page.dart';

import '../../Auth/login.dart';
import '../../ulasan/screens/bookListPage.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListBukuPinjaman(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Reviw buku'),
              onTap: () {
                // Add your redirection logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LOGOUT'),
              onTap: () async {
                final response = await request.logout(
                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                    "http://127.0.0.1:8000/auth/logout/");
                String message = response["message"];
                if (response['status']) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Sampai jumpa"),
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPBApp()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
