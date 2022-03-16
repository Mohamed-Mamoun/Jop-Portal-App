import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jop_portal/helpers/Styles/style.dart';
import 'package:file_picker/file_picker.dart';


FirebaseAuth auth = FirebaseAuth.instance;
File? _image;
final imagepicker = ImagePicker();
const filePicker = FilePicker;
String? downloadUrl;
CollectionReference users = FirebaseFirestore.instance.collection('users');
String? userId = FirebaseAuth.instance.currentUser!.uid;
var jobs = FirebaseFirestore.instance.collection('job');
var id;

var imageName;

  _userdata() async {
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      await jobs
          .doc()
          .get()
          .then((value) => {
               id = value['id']
              });
    }
  }

Future imagePickMethod()async{
 final pick = await imagepicker.pickImage(source: ImageSource.gallery);
 if(pick != null){
   _image = File(pick.path);
   imageName.toString();
   
 }
}
Future filePickMethod()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
if(result != null) {
   File file = File(result.files.single.path.toString());
} 
 
}
Future uploudImage()async{
  Reference ref = FirebaseStorage.instance.ref().child('images').child(imageName);
 await ref.putFile(_image!);
 downloadUrl = await ref.getDownloadURL();
 await users.doc(userId).set({
   'image':downloadUrl
 },SetOptions(
   merge: true
 ));
 if(userId == id){
   jobs.doc().set({'image':downloadUrl},SetOptions(merge: true));
 }

}

void navigateTo(context, page) {
  Navigator.push( context, MaterialPageRoute(builder: (context) => page));
}

void navigateAndFinish(BuildContext context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

Widget button({
  double width = double.infinity,
  Color background= primaryColor,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
  required double horizontal,
  required double vertical 
}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed:() => function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

  Widget formField({
  required TextEditingController controller,
  String? label,
  String? hint,
  required TextInputType type,
  required IconData? prefix,
  IconData? suffix,
  String? Function(String?)? validate,
  Function? onSubmitted,
  Function? onTap,
  Function(String)? onChanged,
  bool isPassword = false,
  bool isReadOnly = false,
  Function? suffixPressed,
  bool? obscureText,
  double radius = 15.0,
  Color? fill
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefix,color: Colors.black87),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: ()=> suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      keyboardType: type,
      obscureText: isPassword,
      // On Submitted Value
     
      // On Chang Value
      onChanged: onChanged,
      validator: validate,
      onTap:() => onTap,
      readOnly: isReadOnly,
    );
   