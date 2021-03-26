import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/sign_in/validators.dart';
import 'package:multi_login_flutter/common_widgets/form_submit_button.dart';
import 'package:multi_login_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
 
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      if (Platform.isIOS) {
      } else {
        PlatformAlertDialog(
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK',
          cancelActionText: 'Cancel',
        ).show(context);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (_) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'enteryouremail@gmail.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (_) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildrens(),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }

  void _toggleFormType() {
    setState(
      () {
        _submitted = false;
        _formType = _formType == EmailSignInFormType.signIn
            ? EmailSignInFormType.register
            : EmailSignInFormType.signIn;
      },
    );
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildrens() {
    final _primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final _secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    bool _submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    return [
      _buildEmailTextField(),
      SizedBox(height: 8),
      _buildPasswordTextField(),
      SizedBox(height: 8),
      FormSubmitButton(
        text: _primaryText,
        onPressed: _submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8),
      TextButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(_secondaryText),
      ),
    ];
  }
}
