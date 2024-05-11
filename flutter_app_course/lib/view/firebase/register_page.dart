import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_course/view/firebase/login_page.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_firebase_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthFirebaseProvider>();
    return Scaffold(
      body: Form(
        key: authProvider.formKeyRegister,
        child: ListView(
          children: [
            const Text(
              'Register Page with Firebase Auth',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                controller: authProvider.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi field ini';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                controller: authProvider.passwordController,
                obscureText: authProvider.obscurePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi field ini';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<AuthFirebaseProvider>()
                              .actionObscurePassword();
                        },
                        icon: Icon(authProvider.obscurePassword == true
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, elevation: 5),
              onPressed: () {
                context.read<AuthFirebaseProvider>().processRegister(context);
              },
              child: const Text("Register",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, elevation: 5),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: const Text("To Login Page",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            bodyMessage(context),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, elevation: 5),
              onPressed: () => context.read<AuthFirebaseProvider>().loginWithGmail(context),
              child: const Text("Login with Gmail",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyMessage(BuildContext context) {
    var state = context.watch<AuthFirebaseProvider>().loginState;
    var username = context.watch<AuthFirebaseProvider>().username;
    var uid = context.watch<AuthFirebaseProvider>().uid;
    switch (state) {
      case StateLogin.initial:
        return const SizedBox();
      case StateLogin.success:
        return Text('Hello, $username dengan No.Hp sebagai berikut $uid');
      case StateLogin.error:
        return Text(context.watch<AuthFirebaseProvider>().messageError);
      default:
        return const SizedBox();
    }
  }
}
