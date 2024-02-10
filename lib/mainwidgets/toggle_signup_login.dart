import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.toggleScreen,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final VoidCallback toggleScreen;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.015,
          ),
        ),
        spacingWidth(screenWidth * 0.01),
        InkWell(
          onTap: toggleScreen,
          child: Text(
            text2,
            style: TextStyle(
              color: Color(0xff02B4BF),
              fontSize: screenHeight * 0.015,
            ),
          ),
        ),
        spacingWidth(screenWidth * 0.01),
      ],
    );
  }
}