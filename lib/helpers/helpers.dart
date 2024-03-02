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

TextFormField textFields({
  required String text,
  required double fontSize,
  TextEditingController? controller, 
}) {
  return TextFormField(
    style: TextStyle(fontSize: fontSize,color: Colors.white),
    controller: controller,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(fontSize: fontSize, color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


LinearGradient circleAvatarGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 163, 239, 249),
        Color.fromARGB(255, 9, 247, 255),
        Color.fromARGB(255, 6, 123, 121),
        Color.fromARGB(255, 57, 2, 255),
        Color.fromARGB(255, 13, 96, 100),
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
        Icons.arrow_back_ios,
        color: Colors.white,
      ));
}

LinearGradient mainGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(230, 8, 68, 95),
        Color.fromARGB(230, 4, 21, 36),
      ]);
}

LinearGradient storyGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(230, 0, 173, 252),
        Color.fromARGB(230, 4, 21, 36),
        Color.fromARGB(230, 24, 125, 213),
      ]);
}
