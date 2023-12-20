import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/ulasan/screens/bookListPage.dart';

import '../../Auth/login.dart';
import '../../peminjaman_buku/screens/pinjam_buku_page.dart';
import '../../peminjaman_buku/widgets/left_drawer_home.dart';

class Beranda extends StatefulWidget {
  Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Beranda> {
  final List<ShopItem> items = [
    ShopItem("Lihat Daftar Buku", const Color(0xFFAA5200)),
    ShopItem("Review Buku", const Color(0xFFAA5200)),
    ShopItem("Logout", const Color(0xFFAA5200)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pustaring"),
          backgroundColor: const Color(0xFFAA5200),
          foregroundColor: const Color(0xFFFFF0A3),
        ),
        drawer: const LeftDrawerHome(),
        backgroundColor: const Color(0xFFFFF0A3),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 45),
                        child: Column(
                          children: [
                            const Text(
                              'Selamat Datang!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFAA5200),
                              ),
                            ),
                            Text(
                              LoginPBPage.uname,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: items.map((item) {
                          return SizedBox(
                            width: 300,
                            height: 76,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShopCard(item),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ShopItem {
  final String name;
  final Color cardColor;

  ShopItem(this.name, this.cardColor);
}

class ShopCard extends StatelessWidget {
  final ShopItem feat;

  const ShopCard(this.feat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: feat.cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (feat.name == "Lihat Daftar Buku") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PinjamBukuPage()));
          } else if (feat.name == "Review Buku") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BookPage()));
          } else if (feat.name == "Logout") {
            final response = await request.logout(
              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                "https://pustaring-b05-tk.pbp.cs.ui.ac.id/auth/logout/");
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
          }
        },
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  feat.name,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Color(0xFF1E1E1E), fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
