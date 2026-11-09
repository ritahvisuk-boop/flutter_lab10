
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text previewer',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD1B3F8),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
