import 'package:flutter/material.dart';
import 'package:multi_login_flutter/services/auth.dart';

class HomePage extends StatelessWidget {

  HomePage({ @required this.auth});
  
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
     await auth.signOut();
    } catch (e) {
      print(e.toString());
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text('Landing page')),
      ),
    );
  }
}
