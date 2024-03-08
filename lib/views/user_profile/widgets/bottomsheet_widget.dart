import 'dart:io';

import 'package:chitchat/views/chat_screen/widgets/image_selector.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/image_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BottomSheetPage extends StatelessWidget {
  UserModel? user;
  BottomSheetPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<FirebaseProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 23, 23, 23),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: size.height * 0.03,
              backgroundColor: Colors.amber,
              child: Icon(
                Iconsax.location,
                color: Colors.white,
              ),
            ),
            spacingWidth(20),
            InkWell(
              onTap: () {
                provider.pickDocument(user!.userId!);
              },
              child: CircleAvatar(
                radius: size.height * 0.03,
                backgroundColor: Color.fromARGB(255, 7, 222, 255),
                child: Icon(
                  Iconsax.document,
                  color: Colors.white,
                ),
              ),
            ),
            spacingWidth(20),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final pro = Provider.of<ImagesProvider>(context);
                    return ImageSelectorDialog(
                      pro: pro,
                      size: size,
                      recieverId: user!.userId!,
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: size.height * 0.03,
                backgroundColor: Color.fromARGB(255, 68, 151, 4),
                child: Icon(
                  Iconsax.gallery,
                  color: Colors.white,
                ),
              ),
            ),
            spacingWidth(20),
            InkWell(
              onTap: () async {
                try {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.video,
                    allowMultiple: false,
                  );
                  if (result != null) {
                    final file = File(result.files.single.path!);
                    ChatService().selectAndSendVideo(file, user!.userId!);
                  } 
                } catch (e) {
                  print('Error picking video: $e');
                }
              },
              child: CircleAvatar(
                radius: size.height * 0.03,
                backgroundColor: Color.fromARGB(255, 255, 81, 7),
                child: Icon(
                  Iconsax.video,
                  color: Colors.white,
                ),
              ),
            ),
            spacingWidth(20),
          ],
        ),
      ),
    );
  }
}
