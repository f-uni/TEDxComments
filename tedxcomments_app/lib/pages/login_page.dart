import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedxcomments_app/pages/home_page.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  late final SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Text(
                'Welcome to',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'TEDxComments',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.apply(color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a username!";
                      } else if (value.length < 3) {
                        return "Username is too short!";
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.account_circle_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      labelText: 'Username',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await prefs.setString(
                          'username', usernameController.text);
                      // print(prefs.getString("username"));
                      _completeLogin();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '"The fewer ideas you have,\nthe less you are willing to change them"\n-Michelangelo',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  void _completeLogin() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}
