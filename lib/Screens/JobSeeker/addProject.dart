import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Components/Styles/style.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();
  final name = TextEditingController();
  CollectionReference f_job = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('freelancing');
  var project = FirebaseFirestore.instance.collection('freelancing');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Add Job'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                        },
                        controller: name,
                        decoration: InputDecoration(
                            hintText: 'Employer Name',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Job Title";
                          }
                        },
                        controller: title,
                        decoration: InputDecoration(
                            hintText: 'Job Title',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter A price";
                          }
                        },
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Price per Hour',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Job Description";
                          }
                          if (value.length < 150) {
                            return 'Job Description is Not Enough, Please Indicate More';
                          }
                        },
                        maxLines: 8,
                        controller: desc,
                        decoration: InputDecoration(
                            hintText: 'Job Description',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    f_job.add({
                      'title': title.text,
                      'description': desc.text,
                      'price': price.text
                    });
                    project.add({
                      'title': title.text,
                      'description': desc.text,
                      'price': price.text,
                      'Name': name.text
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
