import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_portal/Screens/Registration/login.dart';
import 'package:jop_portal/helpers/Styles/style.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userEmail = '';
  String userName = '';
  String userNumber = '';
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
                padding: EdgeInsets.only(left: 310),
                child: IconButton(
                  onPressed: () async {
                    try {
                      await auth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_page()));
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
              child: Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 25, 20),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo_camera,
                          size: 50,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
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
                leading: Icon(Icons.phone, color: Colors.black),
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
                        userNumber,
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
                userEmail = value['email'],
                userName = value['name'],
                userNumber = value['phone_number'],
              });
    }
  }
}
