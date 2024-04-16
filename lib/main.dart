
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sockeyway/firebase_options.dart';
import 'package:sockeyway/screens/splash/splash_screen.dart';

import 'utils/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          return OrientationBuilder(
              builder: (context, orientation){
                SizeConfig().init(constraints, orientation);
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                return MaterialApp(
                  title: 'sockeyway',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                    useMaterial3: true,
                  ),
                  home: const SplashScreen(),
                );
              }
          );
        }
    );
  }
}

