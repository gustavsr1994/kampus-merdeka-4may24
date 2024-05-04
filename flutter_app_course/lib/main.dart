import 'package:flutter/material.dart';
import 'package:flutter_app_course/login_page.dart';

void main() {
  runApp(const ApplicationFirst());
}
class ApplicationFirst extends StatelessWidget {
  const ApplicationFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),);
  }
}