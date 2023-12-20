import 'package:flutter/material.dart';
import 'package:pustaring/Sistem Manajemen/widgets/shop_card.dart';
import 'package:pustaring/peminjaman_buku/widgets/left_drawer_home.dart';

class HomePinjam extends StatelessWidget {
  HomePinjam({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("Pinjam Buku", Icons.add_shopping_cart, Colors.deepOrange),
    ShopItem("Buku Pinjaman Anda", Icons.list, Colors.deepPurple),
    ShopItem("Logout", Icons.logout, Color.fromARGB(255, 98, 196, 12)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Pustaring',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Pustaring: Your friendly book app', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      drawer: const LeftDrawerHome(),
    );
  }
}