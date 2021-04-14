import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
              body: EmailSignInFormStateful(
            onSignedIn: onSignedIn,
          )),
        ),
      ),
    );
  }

  void stubSignInWtithEmailAndPasswordSucceeds() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) => Future<UserId>.value(UserId(uid: '123')));
  }

  void stubSignInWtithEmailAndPasswordThrows() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR_WRONG_PASSWORD'));
  }

  group('sign in', () {
    testWidgets(
        'WHEN user doesn\'t enter the email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is not called'
        'AND user is not signed-in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'WHEN user enters a valid email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is called'
        'AND user is signed in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      stubSignInWtithEmailAndPasswordSucceeds();

      const email = 'email@email.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });
        testWidgets(
        'WHEN user enters an invalid email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is called'
        'AND user is not signed in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      stubSignInWtithEmailAndPasswordThrows();

      const email = 'email@email.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, false);
    });
  });
  group('register', () {
    testWidgets(
        'WHEN user taps on the secondary button'
        'THEN form toggles to registration mode', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets(
        'WHEN user enters the email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is called',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'email@email.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
    });
  });
}
