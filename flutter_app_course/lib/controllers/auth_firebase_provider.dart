import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/view/firebase/outlet_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFirebaseProvider extends ChangeNotifier {
  late SharedPreferences _sharedPref;
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var loginState = StateLogin.initial;
  var username = '';
  var uid = '';
  var messageError = '';
  bool obscurePassword = true;

  void processRegister(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();
    if (formKeyRegister.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        await _sharedPref.setString('uid', uid);
        loginState = StateLogin.success;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OutletPage(
                uid: uid,
              ),
            ));
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
      }
      // if (usernameController.text == 'Admin' &&
      //     passwordController.text == 'Admin') {
      //   username = usernameController.text;
      //   loginState = StateLogin.success;
      // } else {
      //   messageError = 'Username dan password salah. Ulangi!!!';
      //   loginState = StateLogin.error;
      // }
    } else {
      showAlertError(context);
    }

    notifyListeners();
  }

  void processLogin(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();
    if (formKeyLogin.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        await _sharedPref.setString('uid', uid);
        loginState = StateLogin.success;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OutletPage(
                uid: uid,
              ),
            ));
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
      }
    } else {
      showAlertError(context);
    }

    notifyListeners();
  }

  void loginWithGmail(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User dataUser = userCredential.user!;
      username = emailController.text;
      uid = dataUser.uid;
      loginState = StateLogin.success;
    } on FirebaseAuthException catch (error) {
      loginState = StateLogin.error;
      messageError = error.message!;
    } catch (e) {
      loginState = StateLogin.error;
      messageError = e.toString();
    }

    notifyListeners();
  }

  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

enum StateLogin { initial, success, error }

showAlertError(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Periksa kelengkapan datamu!'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      );
    },
  );
}
