import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/helpers/Styles/style.dart';


class Applicant extends StatefulWidget {
  const Applicant({Key? key}) : super(key: key);

  @override
  _ApplicantState createState() => _ApplicantState();
}

class _ApplicantState extends State<Applicant> {
  Stream<QuerySnapshot> applicant = FirebaseFirestore.instance
      .collection('Applicant')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicant Requests'),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: applicant,
        builder: (context, snapshot) {
          var data = snapshot.requireData;
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'There are No Applicant Requests',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 6,
            ));
          }
          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return  _jobs(data.docs[index]['title'], data.docs[index]['Applicant_Name'], data.docs[index]['Applicant_Email'], data.docs[index]['Applicant_Number']);
              });
        },
      ),
    );
  }
  _jobs(String job_title, String applicant_name, String applicant_email,String applicant_number
      ) {
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
                     IconButton(onPressed: (){
                       Navigator.pop(context);
                     }, icon: Icon(Icons.arrow_back_ios),
                     color: Colors.white,
                     )
                   ],
                 ),
                 SizedBox(
                   height: 100,
                 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                color: Colors.white,
                child: ListTile(
                    leading: Icon(Icons.person, color: Colors.black),
                    title:Text(applicant_name,
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.email, color: Colors.black),
                    title: Text(applicant_email,
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.phone, color: Colors.black),
                    title: Text(applicant_number,
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
                offset: Offset(
                  5,5
                )
                
              )
              ],
              color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  '   '+applicant_name,
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Text(
                    '   '+job_title,
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
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
