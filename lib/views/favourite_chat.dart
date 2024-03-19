import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/chat_screen/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouriteChatList extends StatefulWidget {
  const FavouriteChatList({super.key});

  @override
  State<FavouriteChatList> createState() => _FavouriteChatListState();
}

class _FavouriteChatListState extends State<FavouriteChatList> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context,listen: false).getAllFavorite();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final provider=Provider.of<FirebaseProvider>(context);
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
                    itemCount: provider.favoriteList.length,
                    itemBuilder: (context, index) {
                      final favorite = provider.favoriteList[index];
                      print(favorite.userId);
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                user: favorite,
                              ),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                        height: height * 0.09,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 41, 33, 53).withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              '${favorite.userName}',
                              style: GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                            ),
                            leading: GestureDetector(
                              onTap: () {
                                
                              },
                              child: Hero(
                                tag: index,
                                child: Container(
                                  height: height * 0.065,
                                  width: height * 0.065,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage('assets/Designer (2).png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Icon(Icons.favorite,color: Colors.red,)
                        ),
                      ),
                          ),
                        ),
                      ));
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