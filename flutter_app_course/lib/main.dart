import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/comment_page.dart';
import 'package:flutter_app_course/controllers/auth_firebase_provider.dart';
import 'package:flutter_app_course/controllers/comment_provider.dart';
import 'package:flutter_app_course/controllers/login_provider.dart';
import 'package:flutter_app_course/controllers/main_provider.dart';
import 'package:flutter_app_course/form_page.dart';
import 'package:flutter_app_course/login_page.dart';
import 'package:flutter_app_course/main_provider_page.dart';
import 'package:flutter_app_course/product_page.dart';
import 'package:flutter_app_course/view/firebase/register_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'main_page.dart';

void main() {
  initFirebase();
  runApp(const ApplicationFirst());
}

Future initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

}
class ApplicationFirst extends StatelessWidget {
  const ApplicationFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthFirebaseProvider(),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: RegisterPage()
          // home: LoginPage(),
          // home: FormPage(),
          // home: MainPage(),

          // home: MainProviderPage(),
          ),
    );
  }
}
