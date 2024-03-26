import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/views/user_profile/widgets/user_profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  UserModel user;
  UserProfile({
    super.key,
    required this.user,
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color: Color.fromARGB(255, 19, 25, 35),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    spacingHeight(screenHeight * 0.040),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('${widget.user.userName}',
                          style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        '${widget.user.email}',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
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
                    UserDetailsInProfile(text: '${widget.user.phoneNumber!=null?'${widget.user.phoneNumber}':'Phone number not disclosed'}', size: 15, color: Colors.white),
                    spacingHeight(screenHeight * 0.01),
                    Divider(thickness: 0.1),
                    spacingHeight(screenHeight * 0.01),
                    UserDetailsInProfile(
                        color: Colors.grey, text: 'Block user', size: 20),
                    spacingHeight(screenHeight * 0.01),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.16,
              left: 20,
              child: Hero(
                tag: widget.user,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:  Color.fromARGB(255, 40, 49, 62),
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
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        height: screenHeight * 0.15,
                        width: screenHeight * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image:widget.user.profilePicture!=null? NetworkImage(widget.user.profilePicture??''):NetworkImage(UserIcon.proFileIcon)),
                      ),
                  ),
                ),
              ),
            ),),
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
