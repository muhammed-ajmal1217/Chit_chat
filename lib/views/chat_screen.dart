import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/mainwidgets/drawer.dart';
import 'package:chitchat/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int personNumber = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: appBarGradient()),
        ),
        title: Text(
          'Chitchat',
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: backroundGradient()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Ellipses2(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
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
                          backgroundImage: AssetImage('assets/Designer.png'),
                          radius: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '+ New Group Chat ',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        final personNumber = index + 1;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(
                                person:personNumber,
                              ),));
                            },
                            child: ListTile(
                              title: Text('User $personNumber'),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/Designer (2).png'),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(0xff02B4BF),
                                    child: Text(
                                      '$personNumber',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white),
                                    ),
                                  ),
                                  spacingHeight(height * 0.004),
                                  Text(
                                    '${DateFormat('hh:mm a').format(DateTime.now())}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
