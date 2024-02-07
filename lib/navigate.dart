import 'package:flutter/material.dart';
import 'package:flutterscaleapp/homepage.dart';
import 'package:flutterscaleapp/sign_in_page.dart';
import 'package:flutterscaleapp/welcome_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in-facebook': (context) => SignInPage(),
    '/home': (context) => HomePage()
  };
}
