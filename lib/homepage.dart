import 'package:flutter/material.dart';
import 'package:flutterscaleapp/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(WelcomePage.result!.photoURL!),
              radius: 40,
            ),
            Text(WelcomePage.result!.email ?? ''),
            Text(WelcomePage.result!.displayName ?? ''),
          ],
        ),
      ),
    );
  }
}
