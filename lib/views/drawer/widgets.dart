import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTiles extends StatelessWidget {
  String text;
   ListTiles({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text,
          style: GoogleFonts.raleway(
            color: Colors.white,
          )),
      onTap: () {},
    );
  }
}