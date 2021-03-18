import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserId {
  UserId({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<UserId> get onAuthStateChanged;
  Future<UserId> getCurrentUser();
  Future<UserId> signInAnonimously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserId _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserId(uid: user.uid);
  }

  @override
  Stream<UserId> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserId> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;
    // UserId id = currentUser as UserId;
    return _userFromFirebase(currentUser);
  }

  @override
  Future<UserId> signInAnonimously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
