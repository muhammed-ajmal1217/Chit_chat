import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/views/user_profile/widgets/user_profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  int index;
  UserProfile({super.key,required this.index});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: mainGradient()
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 550,
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
                  spacingHeight(60),
                  Text('User${widget.index}',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                  Text('username${widget.index}@gmail.com',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 9, 2, 2)),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileContainers(icon: Icons.add,color:Color(0xff02B4BF) ,),
                        ProfileContainers(icon: Icons.message,color: Colors.green,),
                        ProfileContainers(icon: Icons.share,color: Color(0xffFA7B06),),
                        
                      ],
                    ),
                  ),
                  spacingHeight(20),
                  Divider(thickness: 0.1),
                  spacingHeight(10),
                  UserDetailsInProfile(color: Colors.grey,text: 'About',size: 20),
                  UserDetailsInProfile(color: Colors.white,text: 'Hello i am new to Chitchat...',size: 15),
                  spacingHeight(10),
                  Divider(thickness: 0.1),
                  spacingHeight(10),
                  UserDetailsInProfile(color: Colors.grey,text: 'Block user',size: 20),
                  spacingHeight(10),
                  
                ],
              ),
            ),
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              height: 100,
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
                    backgroundImage: AssetImage('assets/Designer.png',),
                    radius: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: goBackArrow(context),
            
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Icon(Icons.more_vert,color: Colors.white,),
            
            ),
          ],
        ),
      ),
    );
  }
}




