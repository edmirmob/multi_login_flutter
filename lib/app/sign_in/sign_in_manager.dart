import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:multi_login_flutter/services/auth.dart';

class SignInManager{
  
  SignInManager({@required this.auth, @required this.isLoading});

  final AuthBase auth;
  final ValueNotifier isLoading;

//  final StreamController<bool> _isLoadingController = StreamController<bool>();


// Stream<bool> get isLoadingStream => _isLoadingController.stream;

// void dispose(){
//   _isLoadingController.close();
// }

// void _setLoading(bool isLoading)=>_isLoadingController.add(isLoading);

Future<UserId> _signIn(Future<UserId> Function() signInMethod)async{
try {
     isLoading.value = true;
     return await signInMethod();
   } catch (e) {
     rethrow;
   }finally{
     isLoading.value = false;
   }
}

 Future<UserId> signInAnonimously()async => await _signIn(auth.signInAnonimously);

Future<UserId> signInWithGoogle()async => await _signIn(auth.signInWithGoogle);

}