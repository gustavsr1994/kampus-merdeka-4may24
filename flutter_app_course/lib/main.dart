import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/controllers/login_controller.dart';
import 'package:flutter_app_course/firebase_options.dart';
import 'package:flutter_app_course/form_page.dart';
import 'package:flutter_app_course/login_page.dart';
import 'package:flutter_app_course/product_page.dart';
import 'package:flutter_app_course/utils/push_notification_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await initFirebase();
  initNotif();
  runApp(const ApplicationFirst());
}

Future initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future initNotif() async {
  await PushNotificationService().initialize();
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
