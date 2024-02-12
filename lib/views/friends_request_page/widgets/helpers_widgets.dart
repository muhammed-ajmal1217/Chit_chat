import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';

Container requestAccept_Reject(IconData icon) {
  return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(0.1),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Color.fromARGB(163, 255, 255, 255).withOpacity(0.07),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ));
}

Row tabBarContent({required IconData icon, required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon),
      spacingWidth(5),
      Text(text),
    ],
  );
}
