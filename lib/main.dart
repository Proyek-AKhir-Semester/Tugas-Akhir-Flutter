import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:pustaring/Customer Service/cs.dart';
=======
import 'package:pustaring/Sistem Manajemen/screens/menu.dart';

import 'Auth/login.dart';
>>>>>>> d303eb057f2d967efdd0cf5fedeca5a1f5e9fb56

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductPage(),
=======
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
          title: 'Flutter App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          home: LoginPBPage()),
>>>>>>> d303eb057f2d967efdd0cf5fedeca5a1f5e9fb56
    );
  }
}