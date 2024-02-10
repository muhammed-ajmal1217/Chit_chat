import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/main_auth_button.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/mainwidgets/toggle_signup_login.dart';
import 'package:chitchat/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  VoidCallback showLogin;
  SignUpPage({super.key, required this.showLogin});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  top: height * 0.06,
                  left: width * 0.05,
                  right: width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacingHeight(height * 0.01),
                    titlesofAuth(
                        screenHeight: height,
                        title: "Create new\nAccount\nSign-up with\nEmail"),
                      spacingHeight(height*0.02),
                    textFields(text: 'Name', fontSize: 13),
                    spacingHeight(height*0.02),
                    textFields(text: 'E-mail', fontSize: 13),
                    spacingHeight(height*0.01),
                    Text(
                      "Password must be include 8 charecters",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: height * 0.013,
                      ),
                    ),
                    spacingHeight(height*0.01),
                    textFields(text: 'Create password', fontSize: 13),
                    spacingHeight(height*0.02),
                    textFields(text: 'Confirm password', fontSize: 13),
                    spacingHeight(height*0.01),
                    ToggleScreen(
                        screenHeight: height,
                        screenWidth: height,
                        toggleScreen: () => widget.showLogin(),
                        text1: 'login with an existing sccount',
                        text2: 'Login'),
                    spacingHeight(height*0.02),
                    MainButtons(
                      screenHeight: height,
                      text: 'Sign up',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}