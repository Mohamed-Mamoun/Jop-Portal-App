import 'package:flutter/material.dart';
import 'package:jop_portal/helpers/Components.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'Registration/Employer_singup.dart';
import 'Registration/jobSeeker_singup.dart';
import 'Registration/Login/login.dart';



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
              height: 200, width: 250, margin: EdgeInsets.only(top: 20, left: 80),
              decoration: BoxDecoration( 
                image: DecorationImage(image: AssetImage('assests/Logo.jpeg'),
                fit: BoxFit.cover
                )
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
              navigateTo(context, Employer_SingUp());
            
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
            navigateTo(context, JobSeeker_SignUp());
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
             navigateTo(context, Login_page());
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