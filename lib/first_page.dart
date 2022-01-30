import 'package:flutter/material.dart';
import 'package:jop_portal/Registration/Employer_singup.dart';
import 'package:jop_portal/Registration/jobSeeker_singup.dart';
import 'package:jop_portal/Registration/login.dart';
import 'package:jop_portal/Styles/style.dart';
import 'package:path/path.dart';

class First_Page extends StatelessWidget {
  const First_Page({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(padding: EdgeInsets.only(left: 80),
            child: Text('Welcome To Job Portal',
            style: TextStyle(
              fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
            Container(
              height: 120, width: 250, margin: EdgeInsets.only(top: 20, left: 80),
              decoration: BoxDecoration(
                /*
                image: DecorationImage(image: AssetImage('assests/images/logo.png'),
                fit: BoxFit.cover*/
                )
              ),
            
            Padding(padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: Text('SignUp as:',
               style: TextStyle(
              fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> Employer_SingUp()));
            
            }, 
            
            child: Text('Company/Employer',
            style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
            ),
            style: ElevatedButton.styleFrom(
             
              padding: EdgeInsets.all(20),
              primary: primaryColor,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: Text('or',
               style: TextStyle(
              fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
             Padding(padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> JobSeeker_SignUp()));
            }, 
            child: Text('Job Seeker',
            style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(55, 20, 55, 20),
              primary: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(80, 40, 0, 0),
            child: TextButton(onPressed: (){
              Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> Login_page()));
            },
             child: Text('Already Have an account?',
               style: TextStyle(
              fontSize: 22, fontStyle: FontStyle.italic, 
              fontWeight: FontWeight.w500
            ),
            ),)
            ),
            
          ],
        ),
      ),
    );
  }
}