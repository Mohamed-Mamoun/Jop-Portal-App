import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Screens/Navigation/E_bottomnav.dart';
import 'package:jop_portal/Screens/Navigation/J_bottomnavbar.dart';
import 'package:jop_portal/Screens/Registration/login.dart';
import 'package:jop_portal/helpers/Components.dart';

class Auth_Service {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  // **************************************************
  // Creating a Function To Change The Password Show
  void changePassword() {
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
  }

  // **************************************************
  // Getting The User Role from Firestore
  Future getUserRole(value, BuildContext context) async {
    var users =
        await (firestore.collection('users').doc(value.user!.uid).get());
    var data = users.data();
    if (data!['role'] == 'employer') {
      navigateAndFinish(context, E_Bottumnav());
    } else {
      navigateAndFinish(context, j_bottomnavbar());
    }
  }

  // **************************************************
  // Create Job Seeker account and add his data
  Future signUp_JobSeeker(
      TextEditingController email,
      TextEditingController pass,
      TextEditingController number,
      TextEditingController pass2,
      BuildContext context,
      TextEditingController name) async {
    await auth
        .createUserWithEmailAndPassword(
            email: email.text.trim(), password: pass.text.trim())
        .then((value) => {
              users.doc(value.user!.uid).set({
                'name': name.text,
                'email': email.text,
                'phone_number': number.text,
                'role': 'job_seeker'
              }),
              navigateTo(context, Login_page())
            });
  }

  // **************************************************
  // Create Job Seeker account and add his data
  Future signUp_Employer(
      TextEditingController email,
      TextEditingController pass,
      TextEditingController indus,
      TextEditingController name,
      BuildContext context) async {
    await auth
        .createUserWithEmailAndPassword(
            email: email.text.trim(), password: pass.text.trim())
        .then((value) => {
              users.doc(value.user!.uid).set({
                'company_name': name.text,
                'company_email': email.text,
                'company_industry': indus.text,
                'role': 'employer'
              }),
              navigateTo(context, Login_page())
            });
  }

  // **************************************************
  // SignIn the User By The Role
  Future login(TextEditingController email, TextEditingController pass,
      BuildContext context) async {
    await auth
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: pass.text.trim())
        .then((value) => {getUserRole(value, context)});
  }
}
