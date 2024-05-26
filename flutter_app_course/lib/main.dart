import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/controllers/auth_firebase_provider.dart';
import 'package:flutter_app_course/controllers/comment_provider.dart';
import 'package:flutter_app_course/controllers/login_provider.dart';
import 'package:flutter_app_course/controllers/main_provider.dart';
import 'package:flutter_app_course/controllers/track_vehicle_provider.dart';
import 'package:flutter_app_course/controllers/weather_provider.dart';
import 'package:flutter_app_course/utils/push_notification_service.dart';
import 'package:flutter_app_course/view/track_vehicle_page.dart';
import 'package:flutter_app_course/view/weather_page.dart';
import 'package:provider/provider.dart';

import 'calculate_currency_page.dart';
import 'firebase_options.dart';

void main() {
  initFirebase();
}

Future initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationService().initialize();

  runApp(const ApplicationFirst());
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
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(create: (context) => TrackVehicleProvider(),)
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: OutletPage(),
          //home: OutletPage(),
          // home: RegisterPage()

          // home: CalculateCurrencyPage(),
          // home: WeatherPage()
          home: TrackVehiclePage(),
          // home: FormPage(),
          // home: MainPage(),

          // home: MainProviderPage(),
          ),
    );
  }
}
