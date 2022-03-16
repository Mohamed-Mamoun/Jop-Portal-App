import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/helpers/Components.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UploadTask? task;
  var employerName;
  var docid;
  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userName = '';
  String userNumber = '';
  var email = TextEditingController();
  var applicant = FirebaseFirestore.instance.collection('Applicant');
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> jobs =
      FirebaseFirestore.instance.collection('job').snapshots();
  String searchkey = '';
  var result;
  File? file;
  var url;

  selectFile() async {
    result = await FilePicker.platform.pickFiles();
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  uploadFile() async {
    String filename = file!.path.split('/').last;
    final destination = 'files/$filename';
    final ref = FirebaseStorage.instance.ref(destination);
    task = ref.putFile(file!);
   var snapshot = await task!.whenComplete(() => {});
    url = await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: 1000,
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  hintText: 'Search for a Job',
                  hintStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  )),
              onChanged: (value) {
                setState(() {
                  searchkey = value;
                });
              },
            ),
          ),
        ),
        backgroundColor: primaryColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: (searchkey == null || searchkey.trim() == "")
              ? FirebaseFirestore.instance.collection('job').snapshots()
              : FirebaseFirestore.instance
                  .collection('job')
                  .where('SearchIndex', arrayContains: searchkey)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 6,
              ));
            }
            var data = snapshot.requireData;
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return _jobs(
                            data.docs[index]['name'],
                            data.docs[index]['job_title'],
                            'assests/Logo.jpeg',
                            data.docs[index]['id'],
                            data.docs[index]['job_desc']);
                      }),
                ),
              ],
            );
          },
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

  _jobs(
    String company_name,
    String job_title,
    String imgpath,
    String id,
    String job_description,
  ) {
    Job_description(BuildContext context) {
      String file_Name =
          file != null ? file!.path.split('/').last : 'No File Selected';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                company_name,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  file_Name = 'No File Selected';
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgpath),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        job_title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Job Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              '- ' + job_description,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        FutureBuilder(
                            future: _userdata(),
                            builder: (context, snapshot) {
                              return Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return WillPopScope(
                                            onWillPop: () async {
                                              setState(() {
                                                file_Name = 'No File Selected';
                                              });
                                              return true;
                                            },
                                            child: AlertDialog(
                                              content: Container(
                                                height: 300,
                                                width: 300,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Applying Form',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Form(
                                                        key: formKey,
                                                        child: Column(
                                                          children: [
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Please Enter Your Email address";
                                                                }
                                                                if (!RegExp(
                                                                        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                                                    .hasMatch(
                                                                        value)) {
                                                                  return 'Please Enter Correct Email';
                                                                }
                                                              },
                                                              controller: email,
                                                              decoration: const InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .email),
                                                                  labelText:
                                                                      'Email Address'),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  selectFile();
                                                                  if (file !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      file_Name =
                                                                          file!
                                                                              .path;
                                                                    });
                                                                  }
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .white),
                                                                child:
                                                                    const Text(
                                                                  'Upload CV',
                                                                  style: TextStyle(
                                                                      color:
                                                                          primaryColor,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                            Text('$file_Name'),
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await uploadFile();
                                                                  await applicant
                                                                      .add({
                                                                    'id': id,
                                                                    'Name':
                                                                        company_name,
                                                                    'title':
                                                                        job_title,
                                                                    'Applicant_Name':
                                                                        userName,
                                                                    'Applicant_Email':
                                                                        userEmail,
                                                                    'Applicant_Number':
                                                                        userNumber,
                                                                    'Cv':url.toString()
                                                                  });
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    primary:
                                                                        primaryColor,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            30,
                                                                        vertical:
                                                                            10)),
                                                                child:
                                                                    const Text(
                                                                  'Submit',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ))
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text(
                                    "Apply Now",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 15, 50, 15)),
                                ),
                              );
                            })
                      ],
                    ),
                  ],
                ),
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
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 80,
                margin: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage(imgpath))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company_name,
                    style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Text(
                    job_title,
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

  basename(String path) {}
}
