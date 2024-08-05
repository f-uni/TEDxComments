import 'package:flutter/material.dart';
import 'package:tedxcomments_app/pages/home_page.dart';
import 'package:tedxcomments_app/pages/profile_page.dart';
import 'package:tedxcomments_app/pages/search_page.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.page});
  final int page;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: _goto,
      backgroundColor: const Color(0xFF211f26),
      indicatorColor: const Color(0xFF4a4458),
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.inbox),
          icon: Icon(Icons.inbox_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  void _goto(int index) {
    List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const ProfilePage()
    ];
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => pages[index],
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
