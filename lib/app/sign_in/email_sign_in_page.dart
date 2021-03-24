import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/sign_in/email_sign_in_form.dart';
import 'package:multi_login_flutter/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Center(child: Text('Sign in',)),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: EmailSignInForm(auth: auth,)),
        ),
      ),
            backgroundColor: Colors.grey[200],
          );
        }
   
}