import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
File? _image;
final imagepicker = ImagePicker();
String? downloadUrl;
CollectionReference users = FirebaseFirestore.instance.collection('users');
String? userId = FirebaseAuth.instance.currentUser!.uid;
var jobs = FirebaseFirestore.instance.collection('job');
var id;
var fileName;
var imageName;

  _userdata() async {
    var currentUser = await auth.currentUser;
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

