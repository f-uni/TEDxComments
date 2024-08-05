import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(page: 0),
      body: Placeholder()
    );
  }
}