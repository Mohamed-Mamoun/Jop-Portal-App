import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_portal/Screens/JobSeeker/addProject.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class Freelancing extends StatefulWidget {
  const Freelancing({ Key? key }) : super(key: key);

  @override
  _FreelancingState createState() => _FreelancingState();
}

class _FreelancingState extends State<Freelancing> {
  Stream<QuerySnapshot> f_job = FirebaseFirestore.instance.collection('users').
  doc(FirebaseAuth.instance.currentUser!.uid).collection('freelancing').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
         body: StreamBuilder<QuerySnapshot>(
          stream: f_job,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
             if (snapshot.hasError) {
                return Text('Something went wrong');
              }
            if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 6,
                ));
              }
            var data = snapshot.requireData;
            return 
               ListView.builder(
                 itemCount: data.size,
                 itemBuilder: (context, index){
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
      
                      child:Container(
                        child: Row(children: [
                          Icon(Icons.check_circle, size: 60,color: primaryColor,),
                          SizedBox(width: 20,),
                          Text(data.docs[index]['title'],
                          style: TextStyle(
                            fontSize: 24,
                          )
                          ,),
                        ],),
                      ),
                    ),
                  );
                 }
                 );
          }
        ),
     
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProject()));
      },
    backgroundColor: primaryColor,
      child: Icon(Icons.add, size: 30,color: Colors.white,),
      ),
    );
  }
}