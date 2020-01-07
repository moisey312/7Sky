import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproj/models/firestore.dart';
import 'package:testproj/models/storage.dart';
import 'package:testproj/pages/registration/sign_up.dart';
import 'package:testproj/pages/registration/reg_choose.dart';
//целый класс работы с FireBase аутентификацией
abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    FireStoreFuns.id = user.uid;
    FireStoreFuns.getProfile();
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    FireStoreFuns.email = email;
    FireStoreFuns.password = password;
    FireStoreFuns.id = user.uid;
    FireStoreFuns.registration();
    Storage.uploadProfilePhoto();
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}