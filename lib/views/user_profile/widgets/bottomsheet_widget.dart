import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber,
            child: Icon(
              Iconsax.location,
              color: Colors.white,
            ),
          ),
          spacingWidth(20),
          CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(
                255, 7, 247, 255),
            child: Icon(
              Iconsax.camera,
              color: Colors.white,
            ),
          ),
          spacingWidth(20),
          CircleAvatar(
            radius: 30,
            backgroundColor:
                Color.fromARGB(255, 255, 81, 7),
            child: Icon(
              Iconsax.document,
              color: Colors.white,
            ),
          ),
          spacingWidth(20),
          CircleAvatar(
            radius: 30,
            backgroundColor:
                Color.fromARGB(255, 255, 81, 7),
            child: Icon(
              Iconsax.gallery,
              color: Colors.white,
            ),
          ),
          spacingWidth(20),
        ],
      ),
    );
  }
}