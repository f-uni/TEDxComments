import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(page: 1),
      body: Placeholder()
    );
  }
}