import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpSignInPage(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(builder: (context) {
            return SignInPage.create(context);
          }),
        ),
      ),
    );
  }

  testWidgets('email & password navigation', (WidgetTester tester) async {
    await pumpSignInPage(tester);
  });
}
