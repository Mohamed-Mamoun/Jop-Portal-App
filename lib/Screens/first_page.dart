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
            const SizedBox(
              height: 30,
            ),
            const Padding(padding: EdgeInsets.only(left: 80),
            child: const Text('Welcome To Job Portal',
            style: TextStyle(
              fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
            
            Container(
              height: 200, width: 250, margin: const EdgeInsets.only(top: 20, left: 80),
              decoration: const BoxDecoration( 
                image: const DecorationImage(image: AssetImage('assests/1024_preview_rev_1.png'),
                fit: BoxFit.cover
                )
              )
              ),
            
            const Padding(padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: const Text('SignUp as:',
               style: const TextStyle(
              fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: ElevatedButton(onPressed: (){
              navigateTo(context, const Employer_SingUp());
            
            }, 
            
            child: const Text('Company/Employer',
            style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
            ),
            style: ElevatedButton.styleFrom(
             
              padding: const EdgeInsets.all(20),
              primary: primaryColor,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: const Text('or',
               style: const TextStyle(
              fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500
            ),
            ),
            ),
             Padding(padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
            child: ElevatedButton(onPressed: (){
            navigateTo(context, const JobSeeker_SignUp());
            }, 
            child: const Text('Job Seeker',
            style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(55, 20, 55, 20),
              primary: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            ),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(80, 40, 0, 0),
            child: TextButton(onPressed: (){
             navigateTo(context, const Login_page());
            },
             child: const Text('Already Have an account?',
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