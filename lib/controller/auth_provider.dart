import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationService authService = AuthenticationService();
  signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await authService.signinWithEmail(
          email: email, password: password, context: context);
    } catch (e) {
      throw Exception('Signin with Email has error because$e');
    }
    notifyListeners();
  }
  
  signupWithEmail(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      await authService.signupWithEmail(
          email: email, password: password, userName: userName);
    } catch (e) {
      throw Exception('error signup becauase$e');
    }
    notifyListeners();
  }

  signInWithGoogle() async {
    try {
      await authService.signinWithGoogle();
    } catch (e) {
      throw Exception('error signin with google becauase$e');
    }
    notifyListeners();
  }
    signinWithPhone(
      {required String name,
      required String email,
      required String phoneNumber,
      required BuildContext context}) async {
    try {
      await authService.signinWithPhone(
          name: name, email: email, phoneNumber: phoneNumber, context: context);
    } catch (e) {
      throw Exception('Phone auth interrupted$e');
    }
    notifyListeners();
  }
  verifyOtp({required String verificationId,required String otp,required Function onSuccess,required String name,required String email,required String phone}){
    try{
      authService.verifyOtp(verificationId: verificationId, otp: otp, onSuccess: onSuccess,email: email,name: name,phone:phone );
    }catch(e){
      throw Exception('otp verification interrupted because$e');
    }
    notifyListeners();
  }
    signOut() async {
    try {
      await authService.signout();
    } catch (e) {
      throw Exception('error sign out becauase$e');
    }
    notifyListeners();
  }
}

