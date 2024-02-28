import 'package:flutter/material.dart';

class ProfilePictureView extends StatelessWidget {
  const ProfilePictureView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      actionsPadding: EdgeInsets.all(0),
      actions: [
        Image.asset('assets/Designer (2).png')
      ],
    );
  }
}