import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({
    super.key,
    required this.screenHeight,
    required this.image,
    required this.text,
    required this.onPressed,
    
  });

  final double screenHeight;
  final String image;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }
}

