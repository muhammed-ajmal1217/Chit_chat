import 'dart:ui';

import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/main_auth_button.dart';
import 'package:chitchat/mainwidgets/media_auth_button.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/mainwidgets/toggle_signup_login.dart';
import 'package:chitchat/views/chat_screen.dart';
import 'package:chitchat/views/phone_request.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUp;

  LoginPage({Key? key, required this.showSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: backroundGradient()),
        child: Stack(
          children: [
            Ellipses(),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacingHeight(screenHeight * 0.01),
                  titlesofAuth(
                      screenHeight: screenHeight,
                      title:
                          "Lets Connect\nWith your new\nFriends & Have a\nChitChat"),
                  spacingHeight(screenHeight * 0.02),
                  textFields(text: 'E-mail', fontSize: 13),
                  spacingHeight(screenHeight * 0.03),
                  textFields(text: 'Password', fontSize: 13),
                  spacingHeight(screenHeight * 0.01),
                  Text(
                    'Forgot password?',
                    style: TextStyle(color: Color(0xff02B4BF), fontSize: 11),
                  ),
                  spacingHeight(screenHeight * 0.010),
                  MainButtons(
                    screenHeight: screenHeight,
                    text: 'Login',
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        )),
                  ),
                  spacingHeight(screenHeight * 0.01),
                  ToggleScreen(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    text1: 'Create New Account',
                    text2: 'Sign up',
                    toggleScreen: ()=>widget.showSignUp(),
                  ),
                  spacingHeight(screenHeight * 0.010),
                  Center(
                    child: Text(
                      'Or',
                      style: TextStyle(
                          color: Colors.white, fontSize: screenHeight * 0.013),
                    ),
                  ),
                  spacingHeight(screenHeight * 0.01),
                  AuthButtons(
                      image: 'assets/facebook.png',
                      screenHeight: screenHeight,
                      text: 'Sign in with facebook'),
                  spacingHeight(screenHeight * 0.01),
                  AuthButtons(
                      screenHeight: screenHeight,
                      image: 'assets/google.png',
                      text: 'Sign in with google'),
                  Center(
                    child: Text(
                      '____________________________________________________',
                      style: TextStyle(
                          color: Color(0xffFFFFF),
                          fontSize: screenHeight * 0.013),
                    ),
                  ),
                  spacingHeight(screenHeight * 0.01),
                  InkWell(
                      borderRadius: BorderRadius.circular(50),
                      hoverColor: Color.fromARGB(255, 127, 39, 161),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhoneRequestPage(),
                        ));
                      },
                      child: AuthButtons(
                          screenHeight: screenHeight,
                          image: 'assets/phone.png',
                          text: 'Sign in with phone'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
