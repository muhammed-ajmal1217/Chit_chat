import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/user_profile/widgets/user_profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  int index;
  UserProfile({
    super.key,
    required this.index,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: screenHeight * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spacingHeight(screenHeight * 0.060),
                  Text('User${widget.index}',
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Text(
                    'username${widget.index}@gmail.com',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileContainers(
                          icon: Icons.add,
                          color: Color(0xff02B4BF),
                        ),
                        ProfileContainers(
                          icon: Icons.message,
                          color: Colors.green,
                        ),
                        ProfileContainers(
                          icon: Icons.share,
                          color: Color(0xffFA7B06),
                        ),
                      ],
                    ),
                  ),
                  spacingHeight(screenHeight * 0.02),
                  Divider(thickness: 0.1),
                  spacingHeight(screenHeight * 0.01),
                  UserDetailsInProfile(
                      color: Colors.grey, text: 'About', size: 20),
                  UserDetailsInProfile(
                      color: Colors.white,
                      text: 'Hello i am new to Chitchat...',
                      size: 15),
                  spacingHeight(screenHeight * 0.01),
                  Divider(
                    thickness: 0.1,
                  ),
                  spacingHeight(screenHeight * 0.01),
                  UserDetailsInProfile(
                      color: Colors.grey, text: 'Phone number', size: 20),
                  UserDetailsInProfile(
                      color: Colors.white, text: '8089833972', size: 15),
                  spacingHeight(screenHeight * 0.01),
                  Divider(
                    thickness: 0.1,
                  ),
                  spacingHeight(screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserDetailsInProfile(
                          color: Colors.grey,
                          text: 'Mute Notification',
                          size: 20),
                      Switch(  
                        value: false,
                        activeTrackColor: Color.fromARGB(255, 15, 161, 154),
                        activeColor: Color.fromARGB(255, 200, 87, 1),
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        inactiveThumbColor: Color.fromARGB(255, 96, 97, 97),
                        inactiveTrackColor: Colors.black,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  spacingHeight(screenHeight * 0.01),
                  Divider(thickness: 0.1),
                  spacingHeight(screenHeight * 0.01),
                  UserDetailsInProfile(
                      color: Colors.grey, text: 'Block user', size: 20),
                  spacingHeight(screenHeight * 0.01),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.18,
              left: 0,
              right: 0,
              height: 100,
              child: Hero(
                tag: widget.index,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: circleAvatarGradient(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/Designer.png',
                      ),
                      radius: 30,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: goBackArrow(context),
            ),
          ],
        ),
      ),
    );
  }
}
