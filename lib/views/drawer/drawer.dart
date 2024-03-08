import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/views/drawer/widgets.dart';
import 'package:chitchat/views/favourite_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).updateUserName();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer2<AuthenticationProvider, ProfileProvider>(
      builder: (context, authProvider, profilePro, child) => Drawer(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              curve: Curves.bounceInOut,
              decoration: BoxDecoration(gradient: mainGradient()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: width * 0.065,
                            backgroundImage: AssetImage('assets/Designer.png'),
                          ),
                          CircleAvatar(
                            radius: width * 0.025,
                            backgroundColor: Color(0xffFA7B06),
                            child: Icon(Iconsax.camera,color: Colors.white,size: 10,),
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
                              fontSize: width * 0.040,
                            ),
                          ),
                          Text(
                            '${auth.currentUser?.email}',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: width * 0.030,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  spacingHeight(height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello i am new to Chitchat',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: width * 0.040,
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
              onTap: () {},
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
