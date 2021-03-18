import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home_page.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';
import 'package:multi_login_flutter/services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
 


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserId>(
        stream: auth.onAuthStateChanged,
        builder: (ctx, snapshot) {
          UserId user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            if (user == null) {
              return SignInPage(
                title: 'Sign in Page',
               
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
            );
          }else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
