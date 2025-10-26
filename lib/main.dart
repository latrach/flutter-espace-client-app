import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_espace_client_app/bottom_navigation.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espace client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBE9337),
          primary: const Color(0xFFBE9337),
          secondary: const Color(0xFF333333),
          tertiary: const Color(0xFF888888),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
      ),
      home: const BottomNavigation(),
    );
  }
}
