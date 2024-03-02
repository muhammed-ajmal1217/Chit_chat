import 'dart:ui';

import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/main_widgets/main_auth_button.dart';
import 'package:chitchat/main_widgets/media_auth_button.dart';
import 'package:chitchat/main_widgets/bacground_ellipse.dart';
import 'package:chitchat/main_widgets/toggle_signup_login.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/views/chat_screen/chat_screen.dart';
import 'package:chitchat/views/forgot_password_page.dart';
import 'package:chitchat/views/phone_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUp;

  LoginPage({Key? key, required this.showSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
        child: Stack(
          children: [
            Ellipses(),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: SingleChildScrollView(
                child: Consumer<AuthenticationProvider>(
                  builder: (context, authProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacingHeight(screenHeight * 0.01),
                      titlesofAuth(
                          screenHeight: screenHeight * 0.9,
                          title:
                              "Lets Connect\nWith your new\nFriends & Have a\nChitChat"),
                      spacingHeight(screenHeight * 0.02),
                      textFields(
                          controller: emailController,
                          text: 'E-mail',
                          fontSize: 13),
                      spacingHeight(screenHeight * 0.03),
                      textFields(
                          controller: passwordController,
                          text: 'Password',
                          fontSize: 13),
                      spacingHeight(screenHeight * 0.01),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                        },
                        child: Text(
                          'Forgot password?',
                          style:
                              TextStyle(color: Color(0xff02B4BF), fontSize: 11),
                        ),
                      ),
                      spacingHeight(screenHeight * 0.010),
                      MainButtons(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          text: 'Login',
                          onPressed: () => authProvider.signinWithEmail(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context)),
                      spacingHeight(screenHeight * 0.01),
                      ToggleScreen(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        text1: 'Create New Account',
                        text2: 'Sign up',
                        toggleScreen: () => widget.showSignUp(),
                      ),
                      spacingHeight(screenHeight * 0.010),
                      Center(
                        child: Text(
                          'Or',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.013),
                        ),
                      ),
                      spacingHeight(screenHeight * 0.01),
                      AuthButtons(
                        image: 'assets/facebook.png',
                        screenHeight: screenHeight,
                        text: 'Sign in with facebook',
                        onPressed: () async {
                          try {
                            final UserCredential? userCredential =
                                await AuthenticationService()
                                    .signInWithFacebook();
                            if (userCredential != null && context.mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatListPage()));
                            } else {
                              print('Authentication failes');
                            }
                          } catch (e) {
                            print('Error signing in with Facebook: $e');
                          }
                        },
                      ),
                      spacingHeight(screenHeight * 0.01),
                      AuthButtons(
                        screenHeight: screenHeight,
                        image: 'assets/google.png',
                        text: 'Sign in with google',
                        onPressed: () {
                          authProvider.signInWithGoogle();
                        },
                      ),
                      Center(
                        child: Text(
                          '____________________________________________________',
                          style: TextStyle(
                              color: Color(0xffFFFFF),
                              fontSize: screenHeight * 0.013),
                        ),
                      ),
                      spacingHeight(screenHeight * 0.01),
                      AuthButtons(
                        screenHeight: screenHeight,
                        image: 'assets/phone.png',
                        text: 'Sign in with phone',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PhoneRequestPage(),
                          ));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
