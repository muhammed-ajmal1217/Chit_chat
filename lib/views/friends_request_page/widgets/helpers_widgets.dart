import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

InkWell requestAccept_Reject(IconData icon,double height,VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: CircleAvatar(
            radius: height*0.02,
            backgroundColor: Color.fromARGB(163, 255, 255, 255).withOpacity(0.07),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        )),
  );
}

Row tabBarContent({required IconData icon, required String text,required double height}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon),
      spacingWidth(height*0.01),
      Text(text),
    ],
  );
}
