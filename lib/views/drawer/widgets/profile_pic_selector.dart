import 'dart:io';
import 'package:chitchat/controller/image_provider.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePicSelector extends StatelessWidget {
  const ProfilePicSelector({
    super.key,
    required this.pro,
    required this.size,
  });
  final ImagesProvider pro;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      actions: [
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 60,
                  backgroundImage: pro.selectedimage != null
                      ? FileImage(pro.selectedimage!)
                      : const AssetImage('assets/person_icon.png')
                          as ImageProvider,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    pro.imageSelector(source: ImageSource.camera);
                  },
                  child: const Icon(
                    Iconsax.camera,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pro.imageSelector(source: ImageSource.gallery);
                  },
                  child: const Icon(
                    Iconsax.gallery,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  addImage(context);
                  Navigator.of(context).pop();
                },
                child: Center(
                    child: Text(
                  "Add",
                  style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        )
      ],
    );
  }

  addImage(context) async {
    final pro = Provider.of<ImagesProvider>(context, listen: false);
    if (pro.selectedimage != null) {
      AuthenticationService()
          .uploadProfilePicture(File(pro.selectedimage!.path));
    }
  }
}
