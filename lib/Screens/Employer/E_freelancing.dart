import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class E_Freelancing extends StatefulWidget {
  const E_Freelancing({ Key? key }) : super(key: key);

  @override
  _E_FreelancingState createState() => _E_FreelancingState();
}

class _E_FreelancingState extends State<E_Freelancing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey.shade200,
              child: ListView(
                children: [
             _jobs('Tirhal', 'Call Center', 'assests/images/tirhal.jpeg', ''),
             _jobs('Siga', 'Admin assistant', 'assests/images/siga.jpeg', ''),
             _jobs('Bank of Khartoum','Mobile Developer','assests/images/mbok.jpeg','')
    
                ],
              ),
            ),
          
        
        floatingActionButton:FloatingActionButton(
          onPressed: (){},
          
          child: Icon(Icons.add, size: 40,),
          backgroundColor: primaryColor,
          
          ) ,
      ),
    );
  }

    _jobs(String company_name, String job_title , String imgpath, String job_description)
    {
      Job_description(BuildContext context){
        Navigator.push(context, 
          MaterialPageRoute(builder:(ctx)=> Scaffold(
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
          )
        ),
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
            SizedBox(height: 10,),
           
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
                      Text('- '+job_description, 
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
                          onPressed: (){},
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
                            padding: EdgeInsets.fromLTRB(50, 15, 50, 15)
                          ),
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
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: InkWell(
            onTap: (){
          Job_description(context);
            },
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.fromLTRB(8, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage(imgpath))
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(company_name,
                  style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18

                    )
                  ),
                  ),
                   Text(job_title,
                  style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    )
                  ),
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