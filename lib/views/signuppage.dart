import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/authbuttons.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  VoidCallback showLogin;
  SignUpPage({super.key, required this.showLogin});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              Eclipses(),
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
                    titlesofAuth(screenHeight: screenHeight,title: "Create new\nAccount\nSign-up with\nEmail"),
                    textFields(text: 'Name', fontSize: 13),
                    spacingHeight(20),
                    textFields(text: 'E-mail', fontSize: 13),
                    spacingHeight(20),
                    Text(
                      "Password must be include 8 charecters",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: screenHeight * 0.013,
                      ),
                    ),
                    spacingHeight(20),
                    textFields(text: 'Create password', fontSize: 13),
                    spacingHeight(20),
                    textFields(text: 'Confirm password', fontSize: 13),
                    spacingHeight(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log in with Existing Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.015,
                          ),
                        ),
                        spacingWidth(screenWidth * 0.01),
                        InkWell(
                          onTap: () {
                            widget.showLogin();
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Color(0xff02B4BF),
                              fontSize: screenHeight * 0.015,
                            ),
                          ),
                        ),
                        spacingWidth(screenWidth * 0.01),
                      ],
                    ),
                    spacingHeight(20),
                    MainButtons(screenHeight: screenHeight, text: 'Sign up'),
                  ],
                ),
              )
            ],
          ),
        ));
  }


}
