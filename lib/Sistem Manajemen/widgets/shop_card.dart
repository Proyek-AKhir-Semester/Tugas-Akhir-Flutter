import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/Sistem Manajemen/screens/shoplist_form.dart';

import '../../Auth/login.dart';
import '../screens/list_product.dart';
import '../screens/list_ruangan.dart';
import '../screens/tambah_ruangan.dart';

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          if (item.name == "Manage Ruangan") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RuangPage(),
                ));
          }
          else if (item.name == "Manage Peminjaman") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BookPage()));
          }
          else if (item.name == "Tambah Ruangan") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RuanganFormPage()));
          }
          else if (item.name == "Logout") {
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
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}