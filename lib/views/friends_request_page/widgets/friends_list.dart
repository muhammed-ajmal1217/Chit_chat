import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/views/chat_screen/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FriendsList extends StatefulWidget {
  FriendsList({
    Key? key,
  });

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Provider.of<FriendshipProvider>(context, listen: false).getRequest();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<FriendshipProvider>(context);
    return Expanded(
      child: StreamBuilder<List<UserModel>>(
        stream: provider.getFriends(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<UserModel> friends = snapshot.data ?? [];
            if (friends.isEmpty) {
              return Center(
                child: Text(
                  'There are no Friends',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return Consumer<FirebaseProvider>(
                builder: (context, value, child) {
                  final List<UserModel> friendsWithChats =
                      friends.where((friend) {
                    return value.users
                        .any((user) => user.userId == friend.userId);
                  }).toList();

                  return ListView.builder(
                    itemCount: friendsWithChats.length,
                    itemBuilder: (context, index) {
                      UserModel requestData = friendsWithChats[index];
                      final userDetails = value.users.firstWhere(
                          (user) => user.userId == requestData.receiverId);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 33, 43, 61)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                '${auth.currentUser!.uid == requestData.receiverId ? requestData.userName : requestData.recieverName}',
                                style: GoogleFonts.raleway(
                                    color: Colors.white, fontSize: 14),
                              ),
                              leading: GestureDetector(
                                onTap: () {},
                                child: Hero(
                                  tag: index,
                                  child: Container(
                                    height: height * 0.065,
                                    width: height * 0.065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: requestData.profilePicture !=
                                                    null &&
                                                requestData
                                                    .profilePicture!.isNotEmpty
                                            ? NetworkImage(
                                                requestData.profilePicture!)
                                            : NetworkImage(
                                                UserIcon.proFileIcon),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ChatScreen(user: userDetails),
                                      ));
                                    },
                                    child: Icon(
                                      Iconsax.message,
                                      color: Color.fromARGB(255, 10, 213, 189),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  Icon(
                                    Iconsax.profile_delete,
                                    color: Color.fromARGB(255, 244, 79, 54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
