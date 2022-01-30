import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Styles/style.dart';

class New_job extends StatefulWidget {
  const New_job({Key? key}) : super(key: key);

  @override
  _New_jobState createState() => _New_jobState();
}

class _New_jobState extends State<New_job> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var userName;
  var name;

  CollectionReference job = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('jobs');
  var jobs = FirebaseFirestore.instance.collection('job');
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Add Job'),
              backgroundColor: primaryColor,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Form(
                    key: formKey,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: title,
                          decoration: InputDecoration(
                              hintText: 'Job Title',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Job Title";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          maxLines: 8,
                          controller: desc,
                          decoration: InputDecoration(
                              hintText: 'Job Description',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Job Description";
                            }
                            if (value.length < 150) {
                              return 'Job Description is Not Enough, Please Indicate More';
                            }
                          },
                        ),
                      ),
                    ])),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: FutureBuilder(
                      future: _userdata(),
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              List<String> splitlist = title.text.split(' ');
                              List<String> indexList = [];
                              for (int i = 0; i < splitlist.length; i++) {
                                for (int j = 1;
                                    j < splitlist[i].length + 1;
                                    j++) {
                                  indexList.add(splitlist[i]
                                      .substring(0, j)
                                      .toLowerCase());
                                }
                              }
                              job.doc().set({
                                'job_title': title.text,
                                'job_desc': desc.text
                              });
                              jobs.doc().set({
                                'id': currentUser,
                                'name':
                                    TextEditingController(text: userName).text,
                                'job_title': title.text,
                                'job_desc': desc.text,
                                'SearchIndex': indexList
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                        );
                      }),
                ),
              ]),
            )));
  }

  _userdata() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get()
        .then((value) => {
              userName = value['company_name'],
            });
  }
  updateJob(){

  }
}
