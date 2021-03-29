import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:multi_login_flutter/app/sign_in/email-sign_in_model.dart';
import 'package:multi_login_flutter/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});

  final AuthBase auth;
  StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  void dispose() {
    _modelController.close();
  }

  EmailSignInModel _model = EmailSignInModel();

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );

    _modelController.add(_model);
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      // final auth = Provider.of<AuthBase>(context, listen: false);
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    } 
  }
}
