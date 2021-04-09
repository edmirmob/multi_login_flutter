import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:multi_login_flutter/app/sign_in/email-sign_in_model.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:rxdart/rxdart.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});

  final AuthBase auth;
  final _modelSubject = BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());
  

  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;

  void dispose() {
    _modelSubject.close();
  }

  EmailSignInModel get _model => _modelSubject.value;

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _modelSubject.add(_model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    ),);
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
