import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/views/otpscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userEmail='';
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
          UserModel(email: email, userName: userName, userId: user.user?.uid);
      firestore.collection('users').doc(userName).set(userData.toJson());
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
      firestore.collection('users').doc(googleUser.displayName).set(userData.toJson());
    } on FirebaseAuthException catch (e) {
      throw Exception('Signin with google was interrupted because$e');
    }
  }
    signinWithPhone(
      {required String name,
      required String email,
      required String phoneNumber,
      required BuildContext context}) async {
    try {
      await authentication.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        
        verificationCompleted: (phoneAuthCredential) async {
          // var credential =
          //     await authentication.signInWithCredential(phoneAuthCredential);
          // final UserModel userData = UserModel(
          //   email: email,
          //   userName: name,
          //   phoneNumber: credential.user!.phoneNumber,
          // );
          // firestore
          //     .collection('users')
          //     .doc(credential.user!.uid)
          //     .set(userData.toJson());
        },
        verificationFailed: (error) {
          throw Exception(error);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId: verificationId,email: email,name: name,),
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Phone auth is interrupted$e');
    }
  }

  verifyOtp(
      {required String verificationId,
      required String otp,
      required String name,
      required String email,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await authentication.signInWithCredential(credential)).user;

      if (user != null) {
        final UserModel userdata =
            UserModel(email: email, userName: name, userId: user.uid);
        firestore.collection('users').doc(name).set(userdata.toJson());
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
    

Future<UserCredential?> signInWithFacebook() async {
  final List<String> permissions = ['public_profile'];

  final LoginResult loginResult = await FacebookAuth.instance.login(permissions: permissions);

  if (loginResult.status == LoginStatus.success) {
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  } else {
    throw FirebaseAuthException(
      code: 'Facebook login failed',
      message: 'Failed to sign in with Facebook. Please try again.',
    );
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
