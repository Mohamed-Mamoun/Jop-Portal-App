import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class F_Applicant extends StatefulWidget {
  const F_Applicant({Key? key}) : super(key: key);

  @override
  _ApplicantState createState() => _ApplicantState();
}

class _ApplicantState extends State<F_Applicant> {
  Stream<QuerySnapshot> applicant = FirebaseFirestore.instance
      .collection('Applicant')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  openurl(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Requests'),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: applicant,
        builder: (context, snapshot) {
          var data = snapshot.requireData;
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text(
              'There are No Applicant Requests',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ));
          }
          if (!snapshot.hasData) {
            return const Text('no data');
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 6,
            ));
          }
          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return _jobs(
                    data.docs[index]['title'],
                    data.docs[index]['Applicant_Name'],
                    data.docs[index]['Applicant_Email'],
                    data.docs[index]['Applicant_Number'],
                    data.docs[index]['Cv'].toString().split('/').last);
              });
        },
      ),
    );
  }

  _jobs(String job_title, String applicant_name, String applicant_email,
      String applicant_number, String applicant_cv) {
    Job_description(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => SafeArea(
            child: Scaffold(
              backgroundColor: primaryColor,
              body: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.person, color: Colors.black),
                        title: Text(
                          applicant_name,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: primaryColor,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.email, color: Colors.black),
                        title: Text(
                          applicant_email,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: primaryColor,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.phone, color: Colors.black),
                        title: Text(
                          applicant_number,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: primaryColor,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: InkWell(
                      onTap: () {
                      
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(Icons.file_present,
                              color: Colors.black),
                          title: Text(
                            'CV',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              color: primaryColor,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 25, 0),
      child: InkWell(
        onTap: () {
          Job_description(context);
        },
        child: Container(
          height: 85,
          width: 200,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade800,
                    blurRadius: 8,
                    offset: const Offset(5, 5))
              ],
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '   ' + applicant_name,
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Text(
                    '   ' + job_title,
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
