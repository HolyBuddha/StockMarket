import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.normal))
          ),
      home: const HomeScreen(),
    );
  }
}
