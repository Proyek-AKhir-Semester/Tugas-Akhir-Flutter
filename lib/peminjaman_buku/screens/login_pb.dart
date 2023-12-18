import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/peminjaman_buku/screens/pinjam_buku_page.dart';
import 'package:pustaring/models/User.dart';

void main() {
  runApp(const LoginPBApp());
}

class LoginPBApp extends StatelessWidget {
  const LoginPBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPBPage(),
    );
  }
}

class LoginPBPage extends StatefulWidget {
  const LoginPBPage({Key? key}) : super(key: key);
  static String uname = '';

  @override
  _LoginPBPageState createState() => _LoginPBPageState();
}

class _LoginPBPageState extends State<LoginPBPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                LoginPBPage.uname = username;
                String password = _passwordController.text;

                final response = await request.login("http://127.0.0.1:8000/auth/login/", {
                  'username': username,
                  'password': password,
                });


                if (request.loggedIn) {
                  String message = response['message'];
                  username = response['username'];

                  Navigator.pushReplacement(
                    context,
                    // MaterialPageRoute(builder: (context) => HomePinjam()),
                    MaterialPageRoute(builder: (context) => PinjamBukuPage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text("$message Selamat datang, $username.")),
                    );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
