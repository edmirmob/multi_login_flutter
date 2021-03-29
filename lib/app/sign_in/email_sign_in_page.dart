import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/sign_in/email_sign_in_form.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInPage extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Center(child: Text('Sign in',)),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: EmailSignInForm()),
        ),
      ),
            backgroundColor: Colors.grey[200],
          );
        }
   
}