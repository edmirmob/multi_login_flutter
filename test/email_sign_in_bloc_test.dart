import 'package:flutter_test/flutter_test.dart';
import 'package:multi_login_flutter/app/sign_in/email-sign_in_model.dart';
import 'package:multi_login_flutter/app/sign_in/email_sign_in_bloc.dart';
import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  test('WHEN email is updated'
  'AND password is updated'
  'AND submit is called'
  'THEN modelStream emits the correct events', (){
  expect(bloc.modelStream, EmailSignInModel());
  });
}
