import 'package:flutter/material.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'home.dart';

void main() {
  EncryptedSharedPreferences.initialize('1111111111111111'); // 16 chars
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
