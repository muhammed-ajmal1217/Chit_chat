import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteChatList extends StatefulWidget {
  const FavouriteChatList({super.key});

  @override
  State<FavouriteChatList> createState() => _FavouriteChatListState();
}

class _FavouriteChatListState extends State<FavouriteChatList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Chats',style: GoogleFonts.aBeeZee(color: Colors.white),),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  spacingHeight(10),
                  ListView.builder(
                    shrinkWrap: true, 
                    physics: NeverScrollableScrollPhysics(), 
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      final personNumber = index + 1;
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => ChatPage(
                            //     person: personNumber,
                            //   ),
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: height*0.090,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: mainGradient(),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'User $personNumber',
                                        style: GoogleFonts.raleway(
                                            color: Colors.white, fontSize: height*0.02),
                                      ),
                                      
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    radius: height*0.03,
                                    backgroundImage:
                                        AssetImage('assets/Designer (2).png'),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.favorite,color: Colors.red,),
                                      spacingHeight(height * 0.004),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}