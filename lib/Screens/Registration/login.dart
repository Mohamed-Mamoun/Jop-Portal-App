import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jop_portal/Screens/Navigation/E_bottomnav.dart';
import 'package:jop_portal/Screens/Navigation/J_bottomnavbar.dart';
import 'package:jop_portal/Screens/first_page.dart';
import 'package:jop_portal/Services/Auth_services.dart';
import 'package:jop_portal/helpers/Components.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'package:provider/provider.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  Future getUserRole(value) async {
    var users =
        await (FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get());
    var data = users.data();
    if (data!['role'] == 'employer') {
      navigateAndFinish(context, const E_Bottumnav());
    } else {
      navigateAndFinish(context, const j_bottomnavbar());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth_Service>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Login',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 22, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 170,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Text(
                        'Email Address:',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email address";
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: ' Email',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 210),
                      child: Text(
                        'Password:',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.name,
                          controller: pass,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                       auth.login(email, pass, context);
                            
                      } on FirebaseAuthException catch (e) {
                       const snackbsr = SnackBar(content: Text('Email or Password is not correct'));
                       ScaffoldMessenger.of(context).showSnackBar(snackbsr);
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const First_Page()));
                  },
                  child: Text(
                    'Create New account',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 22,
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
