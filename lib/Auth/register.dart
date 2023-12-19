// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'dart:convert' as convert;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password1 = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Daftar Pustaring',
                  ),
                  backgroundColor: const Color(0xFFAA5200),
                  foregroundColor: const Color(0xFFFFF0A3),
                ),
                backgroundColor: const Color(0xFFFFF0A3),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 0.1,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xFFAA5200)),
                              decoration: InputDecoration(
                                hintText: "contoh: rudiSalman",
                                labelText: "Username",
                                labelStyle:
                                const TextStyle(color:Color(0xFFAA5200)),
                                icon: const Icon(Icons.people),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintStyle: const TextStyle(color: Color(0xFFAA5200)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  username = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  username = value!;
                                });
                              },
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(color: Color(0xFFAA5200)),
                              decoration: InputDecoration(
                                hintText: "Masukkan Password",
                                labelText: "Password",
                                labelStyle:
                                const TextStyle(color: Color(0xFFAA5200)),
                                icon: const Icon(
                                  Icons.lock_outline,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintStyle: const TextStyle(color: Color(0xFFAA5200)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  password1 = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  password1 = value!;
                                });
                              },
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(color: Color(0xFFAA5200)),
                              decoration: InputDecoration(
                                hintText: "Konfirmasi Password",
                                labelText: "Konfirmasi Password",
                                labelStyle:
                                const TextStyle(color: Color(0xFFAA5200)),
                                icon: const Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintStyle: const TextStyle(color: Color(0xFFAA5200)),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  password2 = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  password2 = value!;
                                });
                              },
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFAA5200),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Submit to Django server and wait for response
                                  final response = await request.postJson(
                                      "http://127.0.0.1:8000/auth/register/",
                                      convert.jsonEncode(<String, String>{
                                        'username': username,
                                        'password1': password1,
                                        'password2': password2,
                                      }));
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Account has been successfully registered!"),
                                    ));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const LoginPBPage()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "An error occured, please try again."),
                                    ));
                                  }
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFFFFF0A3),
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontSize: 22,
                                    color:Color(0xFFAA5200),
                                    height: 1.5),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Route menu ke counter
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPBPage()),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xFFAA5200),
                                      height: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}