import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends ChangeNotifier {
  String _username = '';
  String get username => _username;

  String _messageError = '';
  String get messageError => _messageError;
  var loginState = StateLogin.initial;

  void processRegister(String userName, String password) async {
    loginState = StateLogin.loading;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: password);
      User user = userCredential.user!;
      loginState = StateLogin.success;
      _messageError = 'Hello ${user.uid}';
    } on FirebaseAuthException catch (error) {
      loginState = StateLogin.error;
      _messageError = error.message!;
    } catch (e) {
      loginState = StateLogin.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }

  void processLogin(String userName, String password) async {
    loginState = StateLogin.loading;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      User user = userCredential.user!;
      loginState = StateLogin.success;
      _messageError = 'Hello ${user.uid}';
      print(_messageError);
    } on FirebaseAuthException catch (error) {
      loginState = StateLogin.error;
      _messageError = error.message!;
    } catch (e) {
      loginState = StateLogin.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }

  void processLoginGoogle() async {
    loginState = StateLogin.loading;
    notifyListeners();
    
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User user = userCredential.user!;
      loginState = StateLogin.success;
      _messageError = 'Hello ${user.uid}';
      print(_messageError);
    }  on FirebaseAuthException catch (error) {
      loginState = StateLogin.error;
      _messageError = error.message!;
    } catch (e) {
      loginState = StateLogin.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }
}

enum StateLogin { initial, loading, success, error }
