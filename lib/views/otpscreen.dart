import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/main_auth_button.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(children: [
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
                goBackArrow(context),
                spacingHeight(width * 0.01),
                spacingHeight(height*0.02),
                titlesofAuth(
                    screenHeight: height, title: 'Enter the OTP'),
                spacingHeight(height*0.02),
                Center(
                    child: Lottie.asset('assets/Animation - 1707475902081.json',
                        height: 240)),
                spacingHeight(height*0.02),
                Center(
                    child: Text(
                  'Please enter the OTP number carefully',
                  style: TextStyle(color: Colors.white),
                )),
                spacingHeight(height*0.02),
                Center(
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: PinTheme(
                        height: 60,
                        width: 60,
                        textStyle: TextStyle(fontSize: 17, color: Colors.white),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                spacingHeight(height*0.04),
                MainButtons(
                  screenHeight: height,
                  screenWidth: width,
                  text: 'Submit',
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChatScreen())),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
