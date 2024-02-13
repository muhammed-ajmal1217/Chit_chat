import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/drawer/widgets.dart';
import 'package:chitchat/views/favourite_chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
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
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/Designer.png'),
                    ),
                    spacingWidth(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'username@gmail.com',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                spacingHeight(height * 0.04),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hello i am new to Chitchat',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavouriteChatList(),));
            },
          ),
          ListTiles(
            text: 'Logout',
            onTap: () {},
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
    );
  }
}