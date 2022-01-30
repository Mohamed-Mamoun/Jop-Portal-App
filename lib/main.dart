import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Styles/style.dart';
import 'package:jop_portal/first_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:jop_portal/onbording.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: OnBoardingScreen()));
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
        nextScreen: First_Page(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: primaryColor,
        duration: 3000,
      ),
    );
  }
}
