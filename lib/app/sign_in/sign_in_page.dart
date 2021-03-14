import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_button.dart';
import 'package:multi_login_flutter/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  final String title;
  const SignInPage({Key key, this.title}) : super(key: key);

  Future<void> _signInAnonimously() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      print('${authResult.user.uid}');
    } catch (e) {
      // print(e.toString());
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(this.title),
      ),
      body: _buildContainer(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48),
          SocialSignInButton(
            assetImage: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
          ),
          SizedBox(height: 8),
          SocialSignInButton(
            assetImage: 'assets/images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8),
          SignInButton(
            text: 'Sign in with email',
            color: Colors.teal[700],
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          SignInButton(
            text: 'Go anonimous',
            color: Colors.lime[300],
            textColor: Colors.black,
            onPressed: _signInAnonimously,
          ),
        ],
      ),
    );
  }
}
