import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Screens/Registration/login.dart';
import 'package:jop_portal/helpers/Components.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canresent = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerification();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailverified(),
      );
    }
  }

  @override
  void dispose() {
    if (isEmailVerified = true) timer.cancel();
    super.dispose();
  }

  Future sendVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
   
  }

  Future checkEmailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Login_page()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Verify Email'),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 250, horizontal: 11),
            child: Column(
              children: [
                const Text(
                  'A verification email has been sent to your email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                button(
                    radius: 8,
                    text: 'Resent Email',
                    function: () => sendVerification())
              ],
            ),
          ),
        );
}
