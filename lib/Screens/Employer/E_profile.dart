import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/Components/Components.dart';
import 'package:jop_portal/Components/Styles/style.dart';
import 'package:jop_portal/Screens/Registration/login.dart';

class E_Profile extends StatefulWidget {
  const E_Profile({Key? key}) : super(key: key);

  @override
  _E_ProfileState createState() => _E_ProfileState();
}

class _E_ProfileState extends State<E_Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userEmail = '';
  String userName = '';
  String userinfo = '';
  dynamic file;
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 340, top: 5),
                child: IconButton(
                  onPressed: () async {
                    try {
                      await auth.signOut();
                     navigateAndFinish(context, Login_page());
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 40,
                    color: Colors.red,
                  ),
                )),
            Center(
              child: FutureBuilder(
                future: _userdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 130,
                      width: 130,
                      child: CircleAvatar(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.grey.shade200,
                        radius: 40.0,
                      ),
                    );
                  }
                  return (image != null)
                      ? Container(
                          height: 130,
                          width: 130,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 110,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            radius: 40.0,
                          ),
                        )
                      : Container(
                          height: 130,
                          width: 130,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            backgroundColor: Colors.grey.shade200,
                            radius: 40.0,
                          ),
                        );
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: secondaryColor),
                    onPressed: () => imagePickMethod(),
                    child: Text(
                      'Select Image',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: secondaryColor),
                    onPressed: () => uploudImage(),
                    child: Text(
                      'Uploud Image',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    )),
              ],
            ),
            Divider(
              height: 60.0,
              color: Colors.black,
              thickness: 1.0,
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: FutureBuilder(
                    future: _userdata(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 28,
                              fontStyle: FontStyle.italic),
                        );
                      }
                      return Text(
                        userName,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: primaryColor,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.black),
                title: FutureBuilder(
                    future: _userdata(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 28,
                              fontStyle: FontStyle.italic),
                        );
                      }
                      return Text(
                        userEmail,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: FutureBuilder(
                    future: _userdata(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 28,
                              fontStyle: FontStyle.italic),
                        );
                      }
                      return Text(
                        userinfo,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: primaryColor,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _userdata() async {
    var currentUser = await auth.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((value) => {
                userEmail = value['company_email'],
                userName = value['company_name'],
                userinfo = value['company_industry'],
                image = value['image'],
              });
    }
  }
}
