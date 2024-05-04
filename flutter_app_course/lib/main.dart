import 'package:flutter/material.dart';
import 'package:flutter_app_course/controllers/login_controller.dart';
import 'package:flutter_app_course/form_page.dart';
import 'package:flutter_app_course/login_page.dart';
import 'package:flutter_app_course/product_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ApplicationFirst());
}

class ApplicationFirst extends StatelessWidget {
  const ApplicationFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: ProductPage()
        home: LoginPage(),
        // home: FormPage(),
      ),
    );
  }
}
