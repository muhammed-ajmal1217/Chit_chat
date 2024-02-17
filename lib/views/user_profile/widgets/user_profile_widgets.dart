import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileContainers extends StatelessWidget {
  IconData icon;
  Color color;
   ProfileContainers({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.15,
      width: screenWidth*0.30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 76, 76, 76),
            blurRadius: 0,
            offset: Offset(0, 3)
          )
        ]
        
      ),
      child: Center(
        child: Icon(icon,color: color,size: 30,),
      ),
    );
  }
}
class UserDetailsInProfile extends StatelessWidget {
  String text;
  double size;
  Color color;
   UserDetailsInProfile({
    super.key,
    required this.text,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment:Alignment.centerLeft ,
        child: Text(text,style: GoogleFonts.raleway(fontSize: size,fontWeight: FontWeight.w500,color:color),)),
    );
  }
}