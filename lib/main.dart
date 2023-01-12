import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/// The root of the mobile application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fifthlab Mobile Dev Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}