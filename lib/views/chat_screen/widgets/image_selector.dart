import 'dart:io';
import 'package:chitchat/controller/image_provider.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageSelectorDialog extends StatelessWidget {
  const ImageSelectorDialog(
      {super.key,
      required this.pro,
      required this.size,
      required this.recieverId});
  final ImagesProvider pro;
  final Size size;
  final String recieverId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      content: Text(
        'Select image',
        style: GoogleFonts.raleway(fontSize: 20,color:Colors.white),
      ),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    pro.imageSelector(source: ImageSource.camera);
                  },
                  child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 15, 122, 180)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Iconsax.camera,
                      color:Color.fromARGB(255, 15, 122, 180),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pro.imageSelector(source: ImageSource.gallery);
                  },
                  child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 15, 122, 180)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Iconsax.gallery,
                      color: Color.fromARGB(255, 15, 122, 180),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: pro.selectedimage != null
                            ? FileImage(pro.selectedimage!)
                            : const AssetImage('assets/no_image.jpg')
                                as ImageProvider)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  sendImage(recieverId, context);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 153, 166, 225)),
                  child: Center(
                      child: Text(
                    "Send",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  sendImage(recieverid, context) async {
    final pro = Provider.of<ImagesProvider>(context, listen: false);
    if (pro.selectedimage != null) {
      ChatService().addImageMessage(recieverid, File(pro.selectedimage!.path));
    }
  }
}
