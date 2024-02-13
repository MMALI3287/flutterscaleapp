import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Facebook'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: _isLoggedIn == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_userObj["email"]),
                  Text(_userObj["name"]),
                  TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then(
                              (value) => setState(
                                () {
                                  _isLoggedIn = false;
                                  _userObj = {};
                                },
                              ),
                            );
                      },
                      child: const Text("Log Out"))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: const Text("Login with Facebook"),
                  onPressed: () async {
                    final LoginResult result = await FacebookAuth.instance
                        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
                    if (result.status == LoginStatus.success) {
                      // you are logged
                      final AccessToken accessToken = result.accessToken!;
                    } else {
                      print(result.status);
                      print(result.message);
                    }
                    // FacebookAuth.instance
                    //     .login(permissions: ["public_profile", "email"]).then(
                    //   (value) {
                    //     FacebookAuth.instance.getUserData().then(
                    //       (userData) async {
                    //         setState(
                    //           () {
                    //             _isLoggedIn = true;
                    //             _userObj = userData;
                    //           },
                    //         );
                    //       },
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
      ),
    );
  }
}
