  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SizedBox spacingHeight(double height) {
    return SizedBox(
              height: height,
            );
  }
  SizedBox spacingWidth(double width) {
    return SizedBox(
              width: width,
            );
  }
TextFormField textFields({required String text, required double fontSize}) {
  return TextFormField(
    style: TextStyle(fontSize: fontSize), 
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(fontSize: fontSize,color: Colors.white), 
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    ),
  );
}

    LinearGradient backroundGradient() {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff040921),
          Color.fromARGB(255, 15, 18, 43).withOpacity(0.8),
          Color.fromARGB(255, 5, 13, 15).withOpacity(0),
      ]);
  }
    Text titlesofAuth({required double screenHeight, required String title}) {
    return Text(
      title,
      style: GoogleFonts.aBeeZee(
        color: Colors.white,
        fontSize: screenHeight * 0.040,
      ),
    );
  }