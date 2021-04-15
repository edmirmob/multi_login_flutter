import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_login_flutter/app/home/home_page.dart';
import 'package:multi_login_flutter/app/landing_page.dart';
import 'package:multi_login_flutter/app/sign_in/sign_in_page.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
   StreamController<UserId> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
     onAuthStateChangedController = StreamController<UserId>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester,
      ) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: LandingPage(),
        ),
      ),
    );
    await tester.pump();
  }
  void stubOnAuthStateChangedYields(Iterable<UserId>onAuthStateChanged){
    onAuthStateChangedController.addStream(Stream<UserId>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged)
    .thenAnswer((_){
   return onAuthStateChangedController.stream;
    });
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([]);

    await pumpLandingPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null user', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([null]);

    await pumpLandingPage(tester);

    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('non-null user', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([UserId(uid: '123')]);

    await pumpLandingPage(tester);

    expect(find.byType(HomePage), findsOneWidget);
  });
}