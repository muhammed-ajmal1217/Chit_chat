import 'package:flutter/material.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({
    super.key,
    required this.screenHeight,
    required this.text,
    required this.onPressed,
  });

  final double screenHeight;
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
      ),
    );
  }
}