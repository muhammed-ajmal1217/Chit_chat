import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/mainwidgets/main_auth_button.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final TextEditingController emailcontroller = TextEditingController();
  final AuthenticationService service = AuthenticationService();
  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    resizeToAvoidBottomInset: false, 
    backgroundColor: Color(0xff3A487A),
    body: SingleChildScrollView( 
      child: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
        child: Stack(
          children: [
            Ellipses(),
            Positioned(
              top: 50,
              left: 20,
              child: goBackArrow(context)),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacingHeight(screenHeight * 0.2),
                  titlesofAuth(
                      screenHeight: screenHeight,
                      title:
                          "Enter your \nE-mail and we will\nsend you\na password\nrest link "),
                  spacingHeight(screenHeight * 0.02),
                  textFields(text: 'Enter your E-mail',controller: emailcontroller, fontSize: 13),
                  spacingHeight(screenHeight * 0.030),
                  MainButtons(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    text: 'Reset password',
                    onPressed: () => service.passwordReset(
                        email: emailcontroller.text.trim(), context: context),
                  ),
                  spacingHeight(screenHeight * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}