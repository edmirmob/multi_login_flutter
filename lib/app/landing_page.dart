import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/home_page.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:multi_login_flutter/services/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<UserId>(
        stream: auth.onAuthStateChanged,
        builder: (ctx, snapshot) {
          UserId user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<DataBase>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomePage());
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
