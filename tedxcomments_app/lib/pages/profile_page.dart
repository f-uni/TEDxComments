import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomNavigationBar(page: 2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              const Icon(
                Icons.account_circle_rounded,
                size: 300,
              ),
              const Text(
                "Username",
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {},
                  child:
                      const Text("Logout", style: TextStyle(color: Colors.red)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
