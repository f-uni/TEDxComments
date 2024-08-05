import 'package:flutter/material.dart';
import 'package:tedxcomments_app/widgets/navigationbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(page: 2),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(
            flex: 1,
          ),
          //   const SizedBox(
          //     height: 100,
          //   ),
          const SizedBox(
              width: 250,
              height: 250,
              child: Icon(
                Icons.account_circle_rounded,
                size: 250,
              )),
          SizedBox(
            child: Text("Username"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    ));
  }
}
