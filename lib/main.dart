import 'package:confeitaria_marketplace/splash/tela_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          //backgroundColor: Color(0xFF00CED1), // Azul piscina
         backgroundColor: Color(0xFFFFAEC9)
        ),
      ),
      home: const TelaScreen(),
    );
  }
}
