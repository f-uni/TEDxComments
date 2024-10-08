import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tedxcomments_app/pages/login_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color(0xFF211f26),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TedxComments',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color(0xFFd0befb),
          secondary: Color(0xFFffd8e4),
          surface: Color(0xFF141218),
          error: Colors.redAccent,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
        primaryColor: const Color(0xFFffd8e4),
      ),
      home: const LoginPage(),
    );
  }
}
