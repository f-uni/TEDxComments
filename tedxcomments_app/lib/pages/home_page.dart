import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';
import 'package:tedxcomments_app/widgets/tags.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(page: 0),
      body: Column(children: [
        Tags()
      ],)
    );
  }
}