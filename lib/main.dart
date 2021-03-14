import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi login Flutter',
      theme: ThemeData(
       
        primarySwatch: Colors.indigo,
      ),
      home: SignInPage(title: 'Login Page'),
    );
  }
}

