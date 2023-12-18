import 'package:flutter/material.dart';
import 'package:pustaring/Sistem Manajemen/widgets/left_drawer.dart';
import 'package:pustaring/Sistem Manajemen/widgets/shop_card.dart';

class Sistem_Manajemen extends StatelessWidget {
  Sistem_Manajemen({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("Manage Peminjaman", Icons.checklist, const Color(0xFFB15D08)),
    ShopItem("Manage Ruangan", Icons.meeting_room, const Color(0xFFB15D08)),
    ShopItem("Tambah Ruangan", Icons.add, const Color(0xFFB15D08)),
    ShopItem("Logout", Icons.logout, const Color(0xFFB15D08)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistem Managemen',
        ),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color(0xFFFFF0A3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items.map((ShopItem item) {
              return Container(
                width: double.infinity, // Use full width
                constraints: BoxConstraints(maxWidth: 200.0), // Set max width
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ShopCard(item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      drawer: const LeftDrawer(),
    );
  }
}
