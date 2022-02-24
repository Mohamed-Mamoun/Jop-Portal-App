import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jop_portal/Services/Auth_services.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'package:provider/provider.dart';

class JobSeeker_SignUp extends StatefulWidget {
  const JobSeeker_SignUp({Key? key}) : super(key: key);

  @override
  _JobSeeker_SignUpState createState() => _JobSeeker_SignUpState();
}

class _JobSeeker_SignUpState extends State<JobSeeker_SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController name = TextEditingController();

  final formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth_Service>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'SignUp',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an Account as a Job Seeker',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // ********** Full Name *********
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                              return 'Please Enter Your Name';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),

                    // ********** Email *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email address";
                            }
                            if (!RegExp(
                                    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                .hasMatch(value)) {
                              return 'Please Enter Correct Email';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: ' Email',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Phone Number *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: number,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp("r'^(?:-?(?:0|[1-9][0-9]*))")
                                    .hasMatch(value)) {
                              return 'Please Enter Your Phone Number';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Password *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: pass,
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password must be more than 8 characters';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Password Confirm *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: pass2,
                          validator: (value) {
                            if (value != pass) {
                              return 'Password dose not match';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                
                try {
                 auth.signUp_JobSeeker(email, pass, number, pass2, context, name);
                } on FirebaseAuthException catch (e) {
                  return print(e);
                }
              
              
              },
              child: Text(
                'SignUp',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.italic),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding: EdgeInsets.fromLTRB(138, 10, 138, 10)),
            ),
          ],
        ),
      ),
    );
  }
}
