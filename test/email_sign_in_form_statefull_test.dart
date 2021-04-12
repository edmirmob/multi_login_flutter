import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_login_flutter/app/sign_in/email_sign_in_form_statefull.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });
  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
          home: Scaffold(
        body: EmailSignInFormStateful(),
      )),
    ));
  }
}
