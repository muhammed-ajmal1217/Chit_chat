  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text messageHeadText(
      {required double height,
      required double height1,
      required Color color,
      required String text}) {
    return Text(text,
        style: GoogleFonts.raleway(color: color, fontSize: height * height1));
  }