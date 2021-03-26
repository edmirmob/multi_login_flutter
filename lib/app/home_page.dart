import 'package:flutter/material.dart';
import 'package:multi_login_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final _didChangedPlatform = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (_didChangedPlatform == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), actions: [
        TextButton(
          onPressed: ()=>_confirmSignOut(context),
          child: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ]),
      body: Container(
        child: Center(child: Text('Landing page')),
      ),
    );
  }
}
