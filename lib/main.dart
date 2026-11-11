import 'package:flutter/material.dart';
import 'screens/inventaris_screen.dart';

void main() {
  runApp(const InventarisApp());
}

class InventarisApp extends StatelessWidget {
  const InventarisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris Laboratorium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const InventarisScreen(),
    );
  }
}
