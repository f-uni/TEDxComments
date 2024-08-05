import 'package:flutter/material.dart';
import 'package:tedxcomments_app/pages/login_page.dart';
import 'package:tedxcomments_app/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
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
        primaryColor: Colors.pink,
      ),
      home: const ProfilePage(),
    );
  }
}