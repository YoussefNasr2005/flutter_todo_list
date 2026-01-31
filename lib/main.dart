import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
          bodySmall: TextStyle(fontSize: 13, color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
