import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';
import 'login.dart';

const Color kMarinho = Color(0xFF0B1F3A);
const Color kCoral = Color(0xFFFF6B4A);
const Color kAreia = Color(0xFFFFF8F0);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Carrinho(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S&M Hotel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kAreia,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kCoral,
          primary: kCoral,
          secondary: kMarinho,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kAreia,
          foregroundColor: kMarinho,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
              color: kMarinho, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kCoral,
            foregroundColor: Colors.white,
            minimumSize: const Size(48, 48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const Login(),
    );
  }
}
