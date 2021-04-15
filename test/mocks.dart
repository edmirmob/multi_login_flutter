import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_login_flutter/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}