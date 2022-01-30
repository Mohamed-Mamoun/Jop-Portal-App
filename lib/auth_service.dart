import 'package:firebase_auth/firebase_auth.dart';

class Auth_Service{
  FirebaseAuth auth = FirebaseAuth.instance;
  // Sign Up user
  Future<String> signup(String email, String password)async{
   try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed up';
   }
   on FirebaseException catch (e)   
   {
    return e.message.toString();
   }
  }

  
}