import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  int person;
   ChatPage({Key? key,required this.person});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: appBarGradient()),
        ),
        leading: goBackArrow(context),
        actions: [
          CircleAvatar()
        ],
        title: Text(
          'User${widget.person}',
          style: GoogleFonts.aBeeZee(color: Colors.white,),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: TextStyle(fontSize: 10),
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            suffixIcon: Icon(Icons.mic,color: Colors.grey,)
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: Icon(Icons.camera,color: Colors.white,),
                      backgroundColor: Color(0xffFA7B06),
                      radius: 30,),
                    spacingWidth(10),
                    CircleAvatar(
                      child: Icon(Icons.send,color: Colors.white,),
                      backgroundColor: Color(0xff02B4BF),
                      radius: 30,),
                    spacingWidth(10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
