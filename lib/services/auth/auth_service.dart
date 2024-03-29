import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();


  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async{
    _googleAuthProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    _googleAuthProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection('reddit').doc('users').collection('user_credentials').doc(userCredential.user!.uid).update({
        'lastLogin' :Timestamp.now(),
      });
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('reddit').doc('users').collection('user_credentials').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'userName':"stickOctopus",
        'email': userCredential.user!.email,
        'photoUrl':userCredential.user!.photoURL,
        'displayName':userCredential.user!.displayName,
        'phoneNumber':userCredential.user!.phoneNumber,
        'emailVerified':userCredential.user!.emailVerified,
        'isAnonymous':userCredential.user!.isAnonymous,
        'lastLogin': Timestamp.now(),
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithGoogleProvider() async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);
      _firestore.collection('reddit').doc('users').collection('user_credentials').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'userName':"stickOctopus",
        'email': userCredential.user!.email,
        'photoUrl':userCredential.user!.photoURL,
        'displayName':userCredential.user!.displayName,
        'phoneNumber':userCredential.user!.phoneNumber,
        'emailVerified':userCredential.user!.emailVerified,
        'isAnonymous':userCredential.user!.isAnonymous,
        'lastLogin': Timestamp.now(),
      }, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signInWithGoogleProvider() async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);
      _firestore.collection('reddit').doc('users').collection('user_credentials').doc(userCredential.user!.uid).update({
        'lastLogin': Timestamp.now(),
      });
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<void> signOut () async {
    return await FirebaseAuth.instance.signOut();
  }




}