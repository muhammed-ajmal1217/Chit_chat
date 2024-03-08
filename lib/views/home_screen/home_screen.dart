import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/message_model.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/views/home_screen/widgets/floating_action_button.dart';
import 'package:chitchat/views/home_screen/widgets/helpers.dart';
import 'package:chitchat/views/home_screen/widgets/story_view_list.dart';
import 'package:chitchat/views/drawer/drawer.dart';
import 'package:chitchat/views/chat_screen/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key,}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatListPage> {
  int personNumber = 0;
  final List<Story> stories = [
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 1',
    ),
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 2',
    ),
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 3',
    ),
  ];
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            spacingWidth(width * 0.02),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: AssetImage('assets/Designer (2).png'))),
            ),
            spacingWidth(width * 0.04),
            Text(
              'Chitchat',
              style: GoogleFonts.raleway(color: Colors.white),
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: Consumer<FirebaseProvider>(
        builder: (context, value, child) => 
         Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: height * 0.08,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: TextFormField(
                  onChanged: (query) {
                    value.filterUsers(query);
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xff1A1A1A),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    prefixStyle: TextStyle(color: Colors.grey),
                    hintText: 'Search...',
                    hintStyle:
                        GoogleFonts.alata(color: Colors.grey, fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.285,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 15),
                            child: Text(
                              'Relations',
                              style: GoogleFonts.raleway(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(
                            height: height * 0.20,
                            child: Row(
                              children: [
                                spacingWidth(width * 0.018),
                                Expanded(
                                  child: StoryList(
                                      stories: stories,
                                      height: height,
                                      personNumber: personNumber),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff1A1A22),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 27, top: 20, bottom: 10, right: 27),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                messageHeadText(
                                    height: height,
                                    height1: 0.027,
                                    color: Colors.white,
                                    text: 'Chats'),
                                spacingWidth(10),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: messageHeadText(
                                          height: height,
                                          height1: 0.015,
                                          color: Color.fromARGB(255, 69, 88, 93),
                                          text: "($personNumber)"),
                                    ),
                                    Icon(
                                      Iconsax.message_2,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width,
                              decoration: const BoxDecoration(
                                  color: Color(0xff1A1A22),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: value.filteredUsers!.isNotEmpty
                                    ? value.filteredUsers!.length
                                    : value.users.length,
                                itemBuilder: (context, index) {
                                  final userdetails =
                                      value.filteredUsers!.isNotEmpty
                                          ? value.filteredUsers![index]
                                          : value.users[index];
                                  if (userdetails.userId !=
                                      FirebaseAuth
                                          .instance.currentUser!.uid) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            splashColor: const Color.fromRGBO(
                                                41, 15, 102, .3),
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                    body: ChatScreen(
                                                        user: userdetails),
                                                  ),
                                                )),
                                            child: ListTile(
                                              leading: Container(
                                                height: height * 0.060,
                                                width: height * 0.060,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/Designer.png'))),
                                              ),
                                              title: Text(
                                                userdetails.userName!,
                                                style: GoogleFonts.raleway(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "Tap to Chat",
                                                style: GoogleFonts.raleway(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: NavigateToFriends(),
    );
  }
}