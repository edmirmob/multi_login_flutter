import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/landing_page.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
           create: (context)=>Auth(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Multi login Flutter',
        theme: ThemeData(
         
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}

