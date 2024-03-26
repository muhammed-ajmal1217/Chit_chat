import 'dart:io';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/views/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';


class AuthenticationService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FacebookAuth facebookAuth = FacebookAuth.instance;
  Reference storage=FirebaseStorage.instance.ref();
  String userEmail = '';
  String? profileUrl="";
  String userName='';
  getUserName()async{
    DocumentSnapshot? userCredential = await firestore.collection('users').doc(authentication.currentUser!.uid).get();
    if(userCredential.exists){
     userName = userCredential.get('name');
    }
    return userName;
  }
  Future<String> getProfilePictureUrl() async {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await firestore
              .collection('users')
              .doc(authentication.currentUser!.uid)
              .get();
      profileUrl = userSnapshot.data()?['profile_picture'];
      return profileUrl??'';
  }
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
        errorCode = "Incorrect email or password";
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
      firestore.collection('users').doc(user.user?.uid).set(userData.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Signup is interrupted because$e');
    }
  }

  signinWithGoogle() async {
    try {
      GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? gauth = await guser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth?.accessToken, idToken: gauth?.idToken);
      UserCredential user =
          await authentication.signInWithCredential(credential);
      User googleUser = user.user!;
      UserModel userData = UserModel(
          userId: googleUser.uid,
          email: googleUser.email,
          userName: googleUser.displayName);
      firestore
          .collection('users')
          .doc(user.user?.uid)
          .set(userData.toJson());
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
              await authentication.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(
              verificationId: verificationId,
              email: email,
              name: name,
              phone: phoneNumber ,
            ),
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
      required String phone,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await authentication.signInWithCredential(credential)).user;

      if (user != null) {
        final UserModel userData =
            UserModel(email: email, userName: name, userId: user.uid);
        firestore.collection('users').doc(name).set(userData.toJson());
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    final List<String> permissions = ['public_profile'];
    final LoginResult loginResult =
        await facebookAuth.login(permissions: permissions);

    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } else {
      throw FirebaseAuthException(
        code: 'Facebook login failed',
        message: 'Failed to sign in with Facebook. Please try again.',
      );
    }
  }

  void passwordReset({required email, context}) async {
    try {
      await authentication.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password reset email sent")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  signout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await facebookAuth.logOut();
      await authentication.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception('couldnt signout because$e');
    }
  }
   bool isGoogleSignIn() {
    final currentUser = authentication.currentUser;
    if (currentUser != null) {
      for (final provider in currentUser.providerData) {
        if (provider.providerId == 'google.com') {
          return true;
        }
      }
    }
    return false;
  }


Future<void> uploadProfilePicture(File image) async {
  try {
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    String fileName = '$timestamp.jpg';
    Reference profilePictureRef = storage.child('profile pictures/$fileName');
    await profilePictureRef.putFile(image);
    String profileUrl = await profilePictureRef.getDownloadURL();
    Map<String, dynamic> profileData = {
      'profile_picture': profileUrl,
    };
    await firestore.collection("users").doc(authentication.currentUser!.uid).update(profileData);
    profileUrl = profileUrl;
  } catch (e) {
    throw Exception('Error uploading profile picture: $e');
  }
}  
deleteMyAccount()async{
  try {
  User? user = authentication.currentUser;
  await user?.delete();
  await firestore.collection('users').doc(authentication.currentUser!.uid).delete();
  print('User account deleted successfully.');
} catch (e) {
  print('Error deleting user account: $e');
}

}
}
