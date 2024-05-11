import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) async{
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection("users").doc(user.user!.uid).set({
        "uid" : user.user!.uid,
        "email" : user.user!.email
      });
      return user;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }


  }

  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid" : userCredential.user!.uid,
        "email" : userCredential.user!.email
      });
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }


  }

  Future<void> signOut(){
    return _auth.signOut();
  }

}