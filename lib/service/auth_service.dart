

import 'package:chitchat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential user = await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (error) {
      String errorCode = 'error with Sign-in';
      if (error.code == 'wrong-password' || error.code == 'user-not-found') {
        errorCode = "Icorrect email or password";
      } else if (error.code == 'user-disabled') {
        errorCode = "User not found";
      } else {
        errorCode = error.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            errorCode,
            style: GoogleFonts.raleway(color: Colors.black),
          )));
      return null;
    }
  }

  signupWithEmail(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      UserCredential user = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userData =
          UserModel(email: email, userName: userName, userId: user.user!.uid);
      firestore.collection('users').doc(user.user!.uid).set(userData.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Signup is interrupted because$e');
    }
  }

  signinWithGoogle() async {
    try {
      GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication gauth = await guser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      UserCredential user =
          await authentication.signInWithCredential(credential);
      User googleUser = user.user!;
      UserModel userData = UserModel(
          userId: googleUser.uid,
          email: googleUser.email,
          userName: googleUser.displayName);
      firestore.collection('users').doc(googleUser.uid).set(userData.toJson());
    } on FirebaseAuthException catch (e) {
      throw Exception('Signin with google was interrupted because$e');
    }
  }

  signout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await authentication.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception('couldnt signout because$e');
    }
  }
}
