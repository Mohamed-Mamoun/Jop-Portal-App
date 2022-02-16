import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:jop_portal/Screens/onbording.dart';
import 'package:device_preview/device_preview.dart';
import 'package:jop_portal/Services/Auth_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<Auth_Service>(create: (context) => Auth_Service()),
      ],
      child: DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assests/output-onlinepngtools.png',
          width: 500,
        ),
        nextScreen: OnBoardingScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        duration: 3000,
      ),
    );
  }
}
