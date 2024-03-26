import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/read_unread_model.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:chitchat/views/home_screen/widgets/floating_action_button.dart';
import 'package:chitchat/views/home_screen/widgets/helpers.dart';
import 'package:chitchat/views/home_screen/widgets/story_view_list.dart';
import 'package:chitchat/views/drawer/drawer.dart';
import 'package:chitchat/views/chat_screen/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatListPage> {
  void initState() {
    super.initState();
    final pro1 = Provider.of<FirebaseProvider>(context, listen: false);
    pro1.getAllUsers();
    final pro = Provider.of<ProfileProvider>(context, listen: false);
    pro.retrieveProfilePictureUrl();
    AuthenticationService().getProfilePictureUrl();
    pro.updateUserName();
    ChatService().getStatus();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
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
            spacingWidth(width * 0.04),
            Text(
              'CHITCHAT',
              style: GoogleFonts.raleway(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Color.fromARGB(255, 19, 25, 35),
      body: Consumer<FirebaseProvider>(
        builder: (context, value, child) => Column(
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
                    fillColor: Color.fromARGB(255, 38, 47, 57),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 144, 142, 142),
                    ),
                    prefixStyle: TextStyle(color: Colors.grey),
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.raleway(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontSize: 14),
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
                      height: height * 0.260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: Text(
                              'RELATIONS',
                              style: GoogleFonts.raleway(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ),
                          Container(
                            height: height * 0.22,
                            child: Row(
                              children: [
                                Container(),
                                Expanded(
                                  child: FutureBuilder(
                                    future: ChatService().getStatus(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        );
                                      } else {
                                        List<Story>? stories = snapshot.data;
                                        return Row(
                                          children: [
                                            spacingWidth(width * 0.018),
                                            Expanded(
                                              child: StoryList(
                                                stories: stories!,
                                                height: height,
                                               
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Color.fromARGB(255, 52, 68, 80),
                      ),
                    ),
                    Container(
                      height: height * 0.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 25, 35),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 27, top: 20, right: 27),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                messageHeadText(
                                    height: height,
                                    height1: 0.020,
                                    color: Colors.white,
                                    text: "CHAT'S"),
                                Row(
                                  children: [
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                // value.filteredUsers.isNotEmpty
                                     value.filteredUsers.length,
                                    // : value.users.length,
                                itemBuilder: (context, index) {
                                  final userDetails =
                                      // value.filteredUsers.isNotEmpty
                                           value.filteredUsers[index];
                                          // : value.users[index];
                                  if (userDetails.userId !=
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    return StreamBuilder(
                                      stream: ChatService()
                                          .getUnreadMessageCountStream(
                                              userDetails.userId ?? ''),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.waiting ||
                                            snapshot.data == null) {
                                          return SizedBox.shrink();
                                        } else if (snapshot.hasError) {
                                          // Handle error state
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          final hasMessages =
                                              snapshot.data?.msgNum != null &&
                                                  snapshot.data!.msgNum == 0;
                                          if (hasMessages) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    leading: Container(
                                                      height: height * 0.060,
                                                      width: height * 0.060,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 42, 45, 47),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 5),
                                                          ),
                                                        ],
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: userDetails
                                                                      .profilePicture !=
                                                                  null
                                                              ? NetworkImage(
                                                                  userDetails
                                                                      .profilePicture!)
                                                              : NetworkImage(
                                                                  UserIcon
                                                                      .proFileIcon),
                                                        ),
                                                      ),
                                                    ),
                                                    title: InkWell(
                                                      onTap: () {
                                                        if (userDetails
                                                                .userId ==
                                                            snapshot.data
                                                                ?.recieverId) {
                                                          ChatService()
                                                              .clearUnreadMsg(
                                                                  userDetails
                                                                          .userId ??
                                                                      '');
                                                        }
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Scaffold(
                                                              body: ChatScreen(
                                                                  user:
                                                                      userDetails),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        userDetails.userName ??
                                                            '',
                                                        style:
                                                            GoogleFonts.raleway(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      snapshot.data?.lastMsg !=
                                                              null
                                                          ? snapshot.data
                                                                  ?.lastMsg ??
                                                              ''
                                                          : 'Tap to chat',
                                                      style:
                                                          GoogleFonts.raleway(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    trailing: (snapshot.data
                                                                        ?.msgNum !=
                                                                    null &&
                                                                snapshot.data!
                                                                        .msgNum ==
                                                                    0) &&
                                                            (userDetails
                                                                    .userId ==
                                                                snapshot.data!
                                                                    .senderId)
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 8,
                                                                width: 8,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.5),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          33,
                                                                          219,
                                                                          243),
                                                                ),
                                                              ),
                                                              Text(
                                                                '${_formatTimestamp(snapshot.data?.time)}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            '${_formatTimestamp(snapshot.data?.time)}',
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  91, 91, 91),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return SizedBox
                                                .shrink(); // Don't render anything if user has no messages
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    return const SizedBox(); // Skip rendering for the current user
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

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp != null) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat.Hm().format(dateTime);
    } else {
      return '';
    }
  }
}
