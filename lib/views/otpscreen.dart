import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/authbuttons.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
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
        final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: backroundGradient()),
        child: Stack(children: [
          Eclipses(),
          Padding(
            padding:  EdgeInsets.only(
              top: screenHeight * 0.06,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                      spacingHeight(20),
                  titlesofAuth(
                      screenHeight: screenHeight,
                      title: 'Enter the OTP'),
                      spacingHeight(20),
                      Center(child: Lottie.asset('assets/Animation - 1707475902081.json',height: 240)),
                      spacingHeight(10),
                      Center(child: Text('Please enter the OTP number carefully',style: TextStyle(color: Colors.white),)),
                      spacingHeight(10),
                      Center(
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: PinTheme(
                            height: 60,
                            width: 60,
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.white),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        
                        ),
                      ),
                      spacingHeight(30),
                      MainButtons(screenHeight: screenHeight, text: 'Submit')
                  
              ],
            ),
          )
        ]),
      ),
    );
  }
}