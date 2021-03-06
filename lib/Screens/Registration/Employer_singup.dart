import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jop_portal/Screens/Registration/Login/cubit/cubit.dart';
import 'package:jop_portal/Screens/Registration/Login/cubit/states.dart';
import 'package:jop_portal/Services/Auth_services.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'package:provider/provider.dart';

class Employer_SingUp extends StatefulWidget {
  const Employer_SingUp({Key? key}) : super(key: key);

  @override
  _Employer_SingUpState createState() => _Employer_SingUpState();
}

class _Employer_SingUpState extends State<Employer_SingUp> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController indus = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth_Service>(context);
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'SignUp',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                 const Text(
                  'Create an Account as Employer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // ********** Full Name *********
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                              return 'Please Enter Your Name';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Company Name',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),

                    // ********** Email *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email address";
                            }
                            if (!RegExp(
                                    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                .hasMatch(value)) {
                              return 'Please Enter Correct Email';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: 'Company Email',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Phone Number *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: indus,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp("^(?![\s.]+)[a-zA-Z\s.]*")
                                    .hasMatch(value)) {
                              return 'Please Enter Your Company Industry';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.home),
                              hintText: 'Company Industry',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Password *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                           obscureText:
                          LoginCubit.get(context).isPasswordShow,
                          controller: pass,
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password must be more than 8 characters';
                            }
                          },
                       
                          decoration: InputDecoration(
                             suffixIcon:
                                        Icon(LoginCubit.get(context).suffix) !=
                                                null
                                            ? IconButton(
                                                onPressed: () {
                                                  LoginCubit.get(context)
                                                      .changePasswordVisib();
                                                },
                                                icon: Icon(
                                                    LoginCubit.get(context)
                                                        .suffix),
                                              )
                                            : null,
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    // ********** Password Confirm *********
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        child: TextFormField(
                          obscureText:
                          LoginCubit.get(context).isPasswordShow,
                          keyboardType: TextInputType.visiblePassword,
                          controller: pass2,
                          validator: (value) {
                            if (pass == value) {
                              return 'Password dose not match';
                            }
                          },
                          decoration: InputDecoration(

                             suffixIcon:
                                        Icon(LoginCubit.get(context).suffix) !=
                                                null
                                            ? IconButton(
                                                onPressed: () {
                                                  LoginCubit.get(context)
                                                      .changePasswordVisib();
                                                },
                                                icon: Icon(
                                                    LoginCubit.get(context)
                                                        .suffix),
                                              )
                                            : null,
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    auth.signUp_Employer(email, pass, indus, name, context);
                  } on FirebaseAuthException catch (e) {
                    return print(e);
                  }
                }
              },
              child: Text(
                'SignUp',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.italic),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.fromLTRB(138, 10, 138, 10)),
            ),
          ],
        ),
      ),
    );

          },
      ),
    );
  }
}