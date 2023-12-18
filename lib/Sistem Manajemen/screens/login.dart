import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pustaring/Sistem%20Manajemen/screens/menu.dart';
import 'package:pustaring/Sistem%20Manajemen/screens/register.dart';

void main() {
  runApp(const LoginPBApp());
}

class LoginPBApp extends StatelessWidget {
  const LoginPBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      home: LoginPBPage(),
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
        title: const Text('Pustaring'),
        backgroundColor: const Color(0xFFAA5200),
        foregroundColor: const Color(0xFFFFF0A3),
      ),
      backgroundColor: const Color(0xFFFFF0A3),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFAA5200), // Button color
                  ),
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
                        MaterialPageRoute(builder: (context) => Sistem_Manajemen()),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text("$message Selamat datang, $username.")),
                        );
                    }
                    else {
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
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFFFFF0A3),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFAA5200), // Button color
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Color(0xFFFFF0A3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}