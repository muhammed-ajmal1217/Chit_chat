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
        hintStyle: TextStyle(fontSize: fontSize, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
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
LinearGradient appBarGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 3, 9, 38),
        Color.fromARGB(255, 3, 9, 38),
        Color.fromARGB(255, 4, 38, 75),
        Color.fromARGB(255, 7, 57, 82),
      ]);
}
LinearGradient circleAvatarGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 2, 226, 255),
        Color.fromARGB(255, 3, 26, 46),
        Color.fromARGB(255, 5, 83, 105),
        Color.fromARGB(255, 17, 211, 255),
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

InkWell goBackArrow(BuildContext context) {
  return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ));
}
