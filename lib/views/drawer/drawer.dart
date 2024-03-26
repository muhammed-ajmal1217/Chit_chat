import 'dart:io';

import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/image_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:chitchat/views/chat_screen/widgets/image_selector.dart';
import 'package:chitchat/views/drawer/widgets/profile_pic_selector.dart';
import 'package:chitchat/views/drawer/widgets/widgets.dart';
import 'package:chitchat/views/favourite_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthenticationService service = AuthenticationService();
  FirebaseAuth auth = FirebaseAuth.instance;
  

  @override
  void initState() {
    super.initState();
    var profilePro = Provider.of<ProfileProvider>(context, listen: false);
    profilePro.updateUserName();
    profilePro.retrieveProfilePictureUrl();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer4<AuthenticationProvider, ProfileProvider, ImagesProvider,
        FirebaseProvider>(
      builder: (context, authProvider, profilePro, imagePro, chatPro, child) =>
          Drawer(
        surfaceTintColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 19, 25, 35),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              curve: Curves.bounceInOut,
              decoration: BoxDecoration(color: Color.fromARGB(255, 20, 27, 39),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                              radius: size.width * 0.065,
                              backgroundColor: Colors.transparent,
                              backgroundImage: profilePro.profileUrl.isNotEmpty
                                  ? NetworkImage(profilePro.profileUrl.isNotEmpty?profilePro.profileUrl:UserIcon.proFileIcon)
                                  : AssetImage('assets/person_icon.png')
                                      as ImageProvider),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final pro =
                                      Provider.of<ImagesProvider>(context);
                                  return ProfilePicSelector(
                                    pro: pro,
                                    size: size,
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: size.width * 0.030,
                              backgroundColor: Color(0xffFA7B06),
                              child: Icon(
                                Iconsax.camera,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacingWidth(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profilePro.userName,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: size.width * 0.040,
                            ),
                          ),
                          Text(
                            '${auth.currentUser?.email}',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: size.width * 0.020,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  spacingHeight(size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello i am new to Chitchat',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: size.width * 0.040,
                          ),
                        ),
                        Icon(
                          Iconsax.edit,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTiles(
              text: 'Terms & Conditions',
              onTap: () {},
            ),
            ListTiles(
              text: 'Profile',
              onTap: () {
                
              },
            ),
            ListTiles(
              text: 'Notification',
              onTap: () {},
            ),
            ListTiles(
              text: "Favourite chat's",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavouriteChatList(),
                ));
              },
            ),
            ListTiles(
              text: 'Logout',
              onTap: () {
                authProvider.signOut();
              },
            ),
            ListTiles(
              text: 'F A Q?',
              onTap: () {},
            ),
            ListTiles(
              text: 'Delete my Account',
              onTap: () {
                AuthenticationService().deleteMyAccount();
              },
            ),
          ],
        ),
      ),
    );
  }

  addProfilePIc(context) async {
    final pro = Provider.of<ImagesProvider>(context, listen: false);
    if (pro.selectedimage != null) {
      AuthenticationService()
          .uploadProfilePicture(File(pro.selectedimage!.path));
    }
  }
}
