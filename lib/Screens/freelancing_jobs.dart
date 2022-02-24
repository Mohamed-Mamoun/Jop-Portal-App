import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/helpers/Styles/style.dart';


class Freelancing_jobs extends StatefulWidget {
  Freelancing_jobs({Key? key}) : super(key: key);

  @override
  _Freelancing_jobsState createState() => _Freelancing_jobsState();
}

class _Freelancing_jobsState extends State<Freelancing_jobs> {
  Stream<QuerySnapshot> job = FirebaseFirestore.instance.collection('freelancing').snapshots();
 var freedata;
 var text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: job,
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
                return _jobs(data.docs[index]['Name'], data.docs[index]['title'], '', data.docs[index]['description']);
                 }
                 );
          }
        ),
     
      
    );
  }
   _userdata()async{
    
  }
 _jobs(String company_name, String job_title, String imgpath,
      String job_description) {
    Job_description(BuildContext context) {
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
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                padding: EdgeInsets.all(30),
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        job_title,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Job Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              '- ' + job_description,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Apply Now",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                padding: EdgeInsets.fromLTRB(50, 15, 50, 15)),
                          ),
                        ),
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
      padding:  EdgeInsets.fromLTRB(20, 10, 25, 0),
      child: InkWell(
        onTap: () {
          Job_description(context);
        },
        child: Container(
          height: 85,
          width: 200,
          decoration: BoxDecoration(
            
              color: Colors.white, borderRadius: BorderRadius.circular(8),
              boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 8,
                offset: Offset(
                  5,5
                )
                
              )]
              ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.fromLTRB(8, 0, 20, 0),
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
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Text(
                    job_title,
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

