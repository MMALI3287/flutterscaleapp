import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterscaleapp/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
  static User? get result => _WelcomePageState.result;
}

class _WelcomePageState extends State<WelcomePage> {
  static User? result = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    Future<String?> signInwithGoogle() async {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
        result = _auth.currentUser;
      } on FirebaseAuthException catch (e) {
        print(e.message);
        throw e;
      }
    }

    Future<void> signOutFromGoogle() async {
      await _googleSignIn.signOut();
      await _auth.signOut();
      result = null;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              Constants.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/sign-in');
                signInwithGoogle();
                User? user = FirebaseAuth.instance.currentUser;
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (result != null) {
                  Navigator.pushNamed(context, '/home');
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'You must be signed in to view the Informations.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Login With Google'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('View User Information'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signOutFromGoogle();
              },
              child: const Text('Logout From Google'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign-in-facebook');
              },
              child: const Text('Sign Up With Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}
