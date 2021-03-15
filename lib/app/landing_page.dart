
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home_page.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';
import 'package:multi_login_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //  var _user = FirebaseAuth.instance.currentUser;
  UserId _user;
//  @override
//   void initState() {
//      _checkCurrentUser();
//     super.initState();
//   }
//  Future<void> _checkCurrentUser()async {
//     UserId _curentUser = await widget.auth.getCurrentUser();
//     _updateUser(_curentUser);
//   }

  void _updateUser(UserId user){
     setState(() {
       _user = user;
     });
  }
  @override
  Widget build(BuildContext context) {
    print('Ovo je user $_user');
    if (_user == null) {
      return SignInPage(
        title: 'Sign in Page',
        onSignIn:_updateUser,
        auth: widget.auth,
      );
    } else {
      return HomePage(onSignOut: ()=>_updateUser(null),auth: widget.auth,);
    }
  }
}
