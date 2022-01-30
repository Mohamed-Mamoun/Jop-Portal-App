import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Employer/new_Job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_portal/Styles/style.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  Stream<QuerySnapshot> job = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('jobs')
      .snapshots();
  var updateJob = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('jobs');
    var jobs = FirebaseFirestore.instance.collection('job');
  var title = TextEditingController();
  var desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('The jobs you offered'),
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: job,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'There are No Jobs You offered',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 6,
              ));
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade800,
                            blurRadius: 8,
                            offset: Offset(5, 5))
                      ]),
                      child: Container(
                        height: 65,
                        child: Card(
                          child: ListTile(
                            title: Text(
                              data.docs[index]['job_title'],
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 450,
                                                width: 450,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Update Job',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: title,
                                                      decoration: InputDecoration(
                                                          labelText: 'Job Title',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller: desc,
                                                      maxLines: 8,
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Job Description',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    primaryColor),
                                                        onPressed: () async {
                                                          await updateJob
                                                              .doc(data.docs[index].id)
                                                              .update({
                                                            'job_title':
                                                                title.text,
                                                            'job_desc': desc.text
                                                          });
                                                           await jobs
                                                              .doc(data.docs[index].id)
                                                              .update({
                                                            'job_title':
                                                                title.text,
                                                            'job_desc': desc.text
                                                          });
                                                          title.text = '';
                                                          desc.text = '';

                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Update')),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await updateJob
                                            .doc(data.docs[index].id).delete();
                                             await jobs
                                            .doc(data.docs[index].id).delete();
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => New_job()));
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
