import 'package:chitchat/controller/chat_page_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  int person;
  ChatPage({Key? key, required this.person});

  @override
  State<ChatPage> createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: mainGradient()),
        ),
        title: Row(
          children: [
            goBackArrow(context),
            spacingWidth(width * 0.02),
            CircleAvatar(
              radius: height * 0.027,
              backgroundImage: AssetImage('assets/Designer.png'),
            ),
            spacingWidth(width * 0.02),
            Text(
              'User${widget.person}',
              style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    )),
                spacingWidth(10),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        child: Consumer<ChatPageProvider>(
          builder: (context, chatPageProvider, child) => 
           Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chatPageProvider.messageList.length,
                  itemBuilder: (context, index) {
                    Color color = index % 2 == 0
                        ? Color.fromARGB(255, 65, 65, 65).withOpacity(0.6)
                        : Color(0xff02B4BF);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        height: height * 0.060,
                        child: Center(
                            child: Text(
                          chatPageProvider.messageList[index],
                          style: TextStyle(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Color.fromARGB(255, 255, 255, 255)),
                        )),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller:chatPageProvider. messageController,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            hintText: 'Message...',
                            hintStyle: TextStyle(color: Colors.white),
                            floatingLabelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            suffixIcon: Icon(
                              Icons.mic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(255, 26, 26, 26),
                      radius: height * 0.036,
                    ),
                    spacingWidth(width * 0.02),
                    InkWell(
                      onTap: () {
                        chatPageProvider.addMessage();
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        backgroundColor: Color(0xff02B4BF),
                        radius: height * 0.036,
                      ),
                    ),
                    spacingWidth(width * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
