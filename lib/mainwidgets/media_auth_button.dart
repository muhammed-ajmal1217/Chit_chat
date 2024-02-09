import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({
    super.key,
    required this.screenHeight,
    required this.image,
    required this.text
  });

  final double screenHeight;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFFFFF),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,height: 35,),
          spacingWidth(6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.020,
            ),
          ),
        ],
      ),
    );
  }
}
class MainButtons extends StatelessWidget {
  const MainButtons({
    super.key,
    required this.screenHeight,
    required this.text,
  });

  final double screenHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFA7B06),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.020,
          ),
        ),
      ),
    );
  }
}