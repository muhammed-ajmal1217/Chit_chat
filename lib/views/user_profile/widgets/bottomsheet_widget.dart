import 'dart:io';
import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/views/chat_screen/widgets/image_selector.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/image_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BottomSheetPage extends StatefulWidget {
  UserModel? user;
  BottomSheetPage({super.key, this.user});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  String locationMessage = '';
  late dynamic lat;
  late dynamic long;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
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
            InkWell(
              onTap: () {
                getCurrentLocation().then((value) {
                   setState(() {
                    locationMessage = 'Latitude: $lat, Longitude: $long';
                  });
                  ChatService().sendLocationMessage('${UserIcon.locationUrl}${lat},${long}',widget.user?.userId??'',);
                });
              },
              child: CircleAvatar(
                radius: size.height * 0.03,
                backgroundColor: Colors.amber,
                child: Icon(
                  Iconsax.location,
                  color: Colors.white,
                ),
              ),
            ),
            spacingWidth(20),
            InkWell(
              onTap: () {
                provider.pickDocument(widget.user!.userId!);
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
                      recieverId: widget.user!.userId!,
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
                    ChatService()
                        .selectAndSendVideo(file, widget.user!.userId!);
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

  getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission==LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission!=LocationPermission.whileInUse && permission!=LocationPermission.always) {
          print("permission denid");
          return null;
        }
      }
      if (permission==LocationPermission.deniedForever) {
        print("Location denied forever");
        return null;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
     lat = position.latitude;
     long = position.longitude;
      });
    } catch (e) {
      
    }
  }
}
