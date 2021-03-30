import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_login_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_manager.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_button.dart';
import 'package:multi_login_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:multi_login_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);

  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final authBase = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: authBase, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonimously(BuildContext context) async {
    // final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      await manager.signInAnonimously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    // final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) {
          return EmailSignInPage();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Sign in page'),
      ),
      body: _buildContainer(context,),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            child: _buildHeader(),
          ),
          SizedBox(height: 48),
          SocialSignInButton(
            assetImage: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () => isLoading ? null : _signInWithGoogle(context),
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
            onPressed: () => isLoading ? null : _signInWithEmail(context),
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
            onPressed: () => isLoading ? null : _signInAnonimously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
