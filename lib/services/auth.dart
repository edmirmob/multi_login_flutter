import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserId {
  UserId({
    @required this.uid,
    @required this.photoUrl,
    @required this.displayName,
  });
  final String uid;
  final String photoUrl;
  final String displayName;
}

abstract class AuthBase {
  Stream<UserId> get onAuthStateChanged;
  Future<UserId> getCurrentUser();
  Future<UserId> signInAnonimously();
  Future<void> signOut();
  Future<UserId> signInWithGoogle();
  Future<UserId> signInWithEmailAndPassword(String email, String password);
  Future<UserId> createUserWithEmailAndPassword(String email, String password);
  //  Future  signInWithFacebook();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserId _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserId(
      uid: user.uid,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<UserId> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing google auth token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<UserId> signInWithEmailAndPassword(
      String email, String password) async {
    final _authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(_authResult.user);
  }

  @override
  Future<UserId> createUserWithEmailAndPassword(
      String email, String password) async {
    final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(_authResult.user);
  }

  // @override
  // Future signInWithFacebook() async {
  //   final facebookLogin = FacebookLogin();
  //   // Future<UserCredential> signinCredential(AuthCredential credent)=>_firebaseAuth.signInWithCredential(credent);
  //   // final result = await facebookLogin.logInWithReadPermissions(["public_profile"]);
  //   // if (result.accessToken != null) {
  //   //   final authResult = await _firebaseAuth.signInWithCredential(credential);
  //   //   return _userFromFirebase(authResult.user);
  //   // } else {
  //   //   throw PlatformException(
  //   //     code: 'ERROR_ABORTED_BY_USER',
  //   //     message: 'Sign in aborted by user',
  //   //   );
  //   // }
  //     FacebookLoginResult _result = await facebookLogin.logIn(["public_profile"]);
  //     switch(_result.status){
  //       case FacebookLoginStatus.cancelledByUser:
  //       print('cancelledByUser');
  //       break;
  //       case FacebookLoginStatus.error:
  //       print('error');
  //       break;
  //       case FacebookLoginStatus.loggedIn:
  //       await _loginWithFacebook(_result);
  //       break;
  //       default:
  //     }
  //     // return _loginWithFacebook(_result);

  // }
  // Future<UserId> _loginWithFacebook(FacebookLoginResult _result)async{
  //   FacebookAccessToken _accessToken =  _result.accessToken;
  //   AuthCredential _credential = FacebookAuthProvider.credential(_accessToken.token);
  //   var a = await _firebaseAuth.signInWithCredential(_credential);
  //   return _userFromFirebase(a.user);
  // }

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
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    //final facebookLogin = FacebookLogin();
    //await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
