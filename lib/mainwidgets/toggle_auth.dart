import 'package:chitchat/views/loginpage.dart';
import 'package:chitchat/views/signuppage.dart';
import 'package:flutter/material.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  bool showLogin=true;
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(showSignUp:toggleScreen ,);
    }else{
      return SignUpPage(showLogin:toggleScreen ,);
    }
  }
  toggleScreen(){
    setState(() {
      showLogin=!showLogin;
    });
  }
}